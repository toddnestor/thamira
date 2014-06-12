class BillingBillsController < ApplicationController
	around_filter :catch_not_found
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]

	def index
		@cb = BillingBill.new
		@today_bills = BillingBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = BillingBill.last_10_bills(user: current_user)
	end
	def create
		@cb = BillingBill.new(cb_params)
		@cb.user ||= current_user
		if @cb.save
			flash[:notice] = "Bill Created Successfully-#{@cb.bill_number}, Total Amount:#{@cb.total}"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Created, #{@cb.errors.full_messages.split(',')}"
			redirect_to billing_bills_path
		end
	end
	def update
		@cb = BillingBill.find(params[:id])
		if @cb.update_attributes(cb_params)
			flash[:notice] = "Bill #{@cb.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Updated, #{@cb.errors.full_messages.split(',')}"
			redirect_to edit_billing_bill_path(@cb)
		end
	end
	def print
		render 'print', layout: false
	end
	def edit
		@cb = BillingBill.find(params[:id])
		@today_bills = BillingBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = BillingBill.last_10_bills(user: current_user)
		@cb = BillingBill.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@cb = BillingBill.find_by(bill_number:search_text)
		if @cb
			redirect_to edit_billing_bill_path(@cb)
		else
			flash[:alert] = "Bill, #{search_text}, Does Not Exist!"
			redirect_to billing_bills_path
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = BillingBill.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls
		end
	end
	private
		def cb_params
			params.require(:billing_bill).permit(:customer_name, :service_name, :amount_paid, :mobile_number, :amount, :user_id, :user, :id, :commit)
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_billing_bill_path(bill) : billing_bills_path	
		end	

		def catch_not_found
		  yield
		rescue ActiveRecord::RecordNotFound
		  redirect_to billing_bills_path, :flash => { :error => "Record not found." }
		end
end