ActiveAdmin.register Enquiry do
	filter :user, collection: proc {User.all.collect{|u| [u.email, u.id]}}
	filter :created_at
end
