class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # check_authorization unless: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
  	unless current_user
  		redirect_to new_user_session_path, :alert => exception.message
  	else
  		redirect_to eb_bills_path, alert: "Not Authorised to Perform this Action!"
  	end
  end
  def after_sign_in_path_for(user)
  	user.admin? ? admin_dashboard_path : eb_bills_path
  end
  def access_denied(user)

  end
end
