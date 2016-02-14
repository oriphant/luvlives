class RegistrationsController < Devise::RegistrationsController
	before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  # Sets route for Devise after sign-up
  def after_sign_up_path_for(resource)
    confirmation_user_path(resource.id)
  end

  # Determines what variable can be saved to the database
  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :avatar)}  
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :status, :bio, :city, :state, :gender, :age, :website, :facebook, :twitter, :linkedin, :avatar)}  
  end

end