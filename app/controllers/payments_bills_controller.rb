class PaymentsBillsController < ApplicationController
	around_filter :catch_not_found
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]

	def index
		@pb = PaymentsBill.new
		@today_bills = PaymentsBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = PaymentsBill.last_10_bills(user: current_user)
	end
	def create
		@pb = PaymentsBill.new(pb_params)
		@pb.user = current_user
		if @pb.save
			flash[:notice] = "Bill Created Successfully-#{@pb.bill_number}, Total Amount:#{@pb.total}"
			redirect_to redirect_destination(@pb)
		else
			flash[:alert] = "Not Created, #{@pb.errors.full_messages.split(',')}"
			redirect_to payments_bills_path
		end
	end
	def update
		@pb = PaymentsBill.find(params[:id])
		if @pb.update_attributes(pb_params)
			flash[:notice] = "Bill #{@pb.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@pb)
		else
			flash[:alert] = "Not Updated, #{@pb.errors.full_messages.split(',')}"
			redirect_to edit_payments_bill_path(@pb)
		end
	end
	def print
		render 'print', layout: false
	end
	def edit
		@pb = PaymentsBill.find(params[:id])
		@today_bills = PaymentsBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = PaymentsBill.last_10_bills(user: current_user)
		@pb = PaymentsBill.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@pb = PaymentsBill.find_by(bill_number:search_text)
		if @pb
			redirect_to edit_payments_bill_path(@pb)
		else
			flash[:alert] = "Bill, #{search_text}, Does Not Exist!"
			redirect_to payments_bills_path
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = PaymentsBill.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls
		end
	end
	private
		def pb_params
			params.require(:payments_bill).permit(:customer_name, :service_name, :network, :mobile_number, :amount)
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_payments_bill_path(bill) : payments_bills_path	
		end	

		def catch_not_found
		  yield
		rescue ActiveRecord::RecordNotFound
		  redirect_to payments_bills_path, :flash => { :error => "Record not found." }
		end
end
