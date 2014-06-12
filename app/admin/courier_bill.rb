ActiveAdmin.register CourierBill do
	filter :user, collection: proc {User.all.collect{|u| [u.email, u.id]}}
	filter :created_at

form do |f|
    f.inputs "Courier Bill" do
      f.input :user_id, as: :select, collection: User.all
      f.input :sender_name
      f.input :sender_mobile_no
      f.input :receiver_name
      f.input :receiver_mobile_no
      f.input :amount
    end
    f.actions
  end
	controller do
	    def permitted_params
	      params.permit :utf8, :_method, :authenticity_token, :commit, :id, :user_id,
	      				billing_bill: [:id, :model, :sender_name, :sender_mobile_no, :receiver_name, :receiver_mobile_no, :customer_name, :service_name, :mobile_number, :amount, :user_id]
	    end
	end
end
