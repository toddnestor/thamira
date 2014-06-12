class CourierBillsController < ApplicationController
	around_filter :catch_not_found
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]
	def index
		@courier = CourierBill.new
		@today_bills = CourierBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = CourierBill.last_10_bills(user: current_user)
	end
	def create
		@courier = CourierBill.new(courier_params)
		@courier.user = current_user
		if @courier.save
			flash[:notice] = "Bill Created Successfully-#{@courier.bill_number}, Total Amount:#{@courier.total}"
			redirect_to redirect_destination(@courier)
		else
			flash[:alert] = "Not Created, #{@courier.errors.full_messages.split(',')}"
			redirect_to courier_bills_path
		end
	end
	def update
		@courier = CourierBill.find(params[:id])
		if @courier.update_attributes(courier_params)
			flash[:notice] = "Bill #{@courier.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@courier)
		else
			flash[:alert] = "Not Updated, #{@courier.errors.full_messages.split(',')}"
			redirect_to edit_courier_bill_path(@courier)
		end
	end
	def print
		render 'print', layout: false
	end
	def edit
		@today_bills = CourierBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@last_10_bills = CourierBill.last_10_bills(user: current_user)
		@courier = CourierBill.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@courier = CourierBill.find_by(bill_number:search_text)
		if @courier
			redirect_to edit_courier_bill_path(@courier)
		else
			flash[:alert] = "Bill, #{search_text}, Does Not Exist!"
			redirect_to courier_bills_path
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = CourierBill.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls
		end
	end
	private
		def courier_params
			params.require(:courier_bill).permit(:sender, :sender_mobile_no, :receiver, :receiver_mobile_no, :amount, :bill_number)
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_courier_bill_path(bill) : courier_bills_path	
		end	

		def catch_not_found
		  yield
		rescue ActiveRecord::RecordNotFound
		  redirect_to courier_bills_path, :flash => { :error => "Record not found." }
		end
end
