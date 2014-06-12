class EnquiriesController < ApplicationController
	around_filter :catch_not_found
	load_and_authorize_resource only: [:edit, :update, :print]
	authorize_resource except: [:edit, :update]

	def index
		@cb = Enquiry.new
		@today_bills = Enquiry.today_bills(user: current_user)
		@last_10_bills = Enquiry.last_10_bills(user: current_user)
	end
	def create
		@cb = Enquiry.new(cb_params)
		@cb.user = current_user
		if @cb.save
			flash[:notice] = "Enquiry Created Successfully-#{@cb.bill_number}"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Created, #{@cb.errors.full_messages.split(',')}"
			redirect_to enquiries_path
		end
	end
	def update
		@cb = Enquiry.find(params[:id])
		if @cb.update_attributes(cb_params)
			flash[:notice] = "Enquiry #{@cb.bill_number}, Updated Successfully"
			redirect_to redirect_destination(@cb)
		else
			flash[:alert] = "Not Updated, #{@cb.errors.full_messages.split(',')}"
			redirect_to edit_enquiry_path(@cb)
		end
	end
	def print
		render 'print', layout: false
	end
	def edit
		@cb = Enquiry.find(params[:id])
		@today_bills = Enquiry.today_bills(user: current_user)
		@last_10_bills = Enquiry.last_10_bills(user: current_user)
		@cb = Enquiry.find(params[:id])
		render 'index'
	end
	def search
		search_text = params[:search]
		@cb = Enquiry.find_by(bill_number:search_text)
		if @cb
			redirect_to edit_enquiry_path(@cb)
		else
			flash[:alert] = "Bill, #{search_text}, Does Not Exist!"
			redirect_to enquiries_path
		end
	end
	def export
		export_date = params[:export_date].to_date
		@records = Enquiry.bills_at(export_date, user: current_user)
		
		respond_to do |format|
			format.xls
		end
	end
	private
		def cb_params
			params.require(:enquiry).permit(:customer_name, :service_name, :mobile_number)
		end
		def redirect_destination(bill)
			params[:commit] == "Print & Save" ? print_enquiry_path(bill) : enquiries_path	
		end	

		def catch_not_found
		  yield
		rescue ActiveRecord::RecordNotFound
		  redirect_to enquiries_path, :flash => { :error => "Record not found." }
		end
end
