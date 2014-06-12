ActiveAdmin.register EbBill do
	filter :user, collection: proc {User.all.collect{|u| [u.email, u.id]}}
	filter :created_at

form do |f|
    f.inputs "Electricity Bill" do
      f.input :user_id, as: :select, collection: User.all
      f.input :service_name
      f.input :service_number
      f.input :mobile_number
      f.input :amount
    end
    f.actions
  end
	controller do
	    def permitted_params
	      params.permit :utf8, :_method, :authenticity_token, :commit, :id, :user_id, :eb_bill,
	      				eb_bill: [:id, :service_name, :service_number, :service_name, :mobile_number, :amount, :user_id]
	    end
	end
end
