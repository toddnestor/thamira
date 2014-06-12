class ClothsBillsController < ApplicationController
	around_filter :catch_not_found
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]

	def index
		@cb = ClothsBill.new
		@today_bills = ClothsBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = ClothsBill.last_10_bills(user: current_user)
	end
	def create
		@cb = ClothsBill.new(cb_params)
		@cb.user ||= current_user
		if @cb.save
			flash[:notice] = "Bill Created Successfully-#{@cb.bill_number}, Total Amount:#{@cb.total}"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Created, #{@cb.errors.full_messages.split(',')}"
			redirect_to cloths_bills_path
		end
	end
	def update
		@cb = ClothsBill.find(params[:id])
		if @cb.update_attributes(cb_params)
			flash[:notice] = "Bill #{@cb.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Updated, #{@cb.errors.full_messages.split(',')}"
			redirect_to edit_cloths_bill_path(@cb)
		end
	end
	def print
		render 'print', layout: false
	end
	def edit
		@cb = ClothsBill.find(params[:id])
		@today_bills = ClothsBill.today_bills(user: current_user)
		@today_bills_amount = @today_bills.sum(:amount)
		@today_bills_total_amount = @today_bills.sum(:total)
		@last_10_bills = ClothsBill.last_10_bills(user: current_user)
		@cb = ClothsBill.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@cb = ClothsBill.find_by(bill_number:search_text)
		if @cb
			redirect_to edit_cloths_bill_path(@cb)
		else
			flash[:alert] = "Bill, #{search_text}, Does Not Exist!"
			redirect_to cloths_bills_path
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = ClothsBill.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls 
		end
	end
	private
		def cb_params
			params.require(:cloths_bill).permit(:customer_name, :service_name, :model, :mobile_number, :amount, :user, :user_id, :id, :commit)
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_cloths_bill_path(bill) : cloths_bills_path	
		end	

		def catch_not_found
		  yield
		rescue ActiveRecord::RecordNotFound
		  redirect_to cloths_bills_path, :flash => { :error => "Record not found." }
		end
end
