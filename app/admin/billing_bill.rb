ActiveAdmin.register BillingBill do
	filter :user, collection: proc {User.all.collect{|u| [u.email, u.id]}}
	filter :created_at

form do |f|
    f.inputs "Billing" do
      f.input :user_id, as: :select, collection: User.all
      f.input :customer_name
      f.input :service_name, as: :select, collection: ["ADVERTISEMENT","CONSULTANCY","COMPUTERS","FOOD","OTHERS","MATRIMONY","SOFTWARES","TOURS","TICKETS","VEHICLE RENTAL"]
      f.input :mobile_number
      f.input :amount
    end
    f.actions
  end
	controller do
	    def permitted_params
	      params.permit :utf8, :_method, :authenticity_token, :commit, :id, :user_id,
	      				billing_bill: [:id, :customer_name, :service_name, :mobile_number, :amount, :user_id]
	    end
	end
end
