class EbBillsController < ApplicationController
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]
	def index
		@eb = EbBill.new
		@today_bills = EbBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:total)
		@last_10_bills = EbBill.last_10_bills(user: current_user)
	end
	def create
		@eb = EbBill.new(eb_params)
		@eb.user = current_user
		if @eb.save
			flash[:notice] = "Bill Created Successfully-#{@eb.bill_number}, Total Amount:#{@eb.total}"
			redirect_to redirect_destination(@eb)
		else
			# show error message
			render 'index'
		end
	end
	def update
		@eb = EbBill.find(params[:id])
		if @eb.update_attributes(eb_update_params)
			flash[:notice] = "Bill #{@eb.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@eb)
		else
			# show error message for not update
			flash[:alert] = "Not Updated, #{@eb.errors.full_messages.split(',')}"
			redirect_to edit_eb_bill_path(@eb)
		end
	end
	def print
		
	end
	def edit
		@today_bills = EbBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:total)
		@last_10_bills = EbBill.last_10_bills(user: current_user)
		@eb = EbBill.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@eb = EbBill.find_by(bill_number:search_text)
		if @eb
			redirect_to edit_eb_bill_path(@eb)
		else
			# show this error in the page itself
			render text: "Not Found"
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = EbBill.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls
		end
	end
	private
		def eb_params
			params.require(:eb_bill).permit(:service_name, :service_number, :mobile_number, :amount, :total, :bill_number)	
		end
		def eb_update_params
			params.require(:eb_bill).permit(:service_name, :service_number, :mobile_number, :amount, :total)	
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_eb_bill_path(bill) : eb_bills_path	
		end	
end
