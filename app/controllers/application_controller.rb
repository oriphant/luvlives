class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Sets route for Devise after sign-in
  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      confirmation_user_path(resource.id)
    else  
      questions_path(resource.id)
    end
  end

# ~~~~ CURRENTLY NOT BEING USED ~~~~
  # Sets route for Devise after sign-up
  def after_inactive_sign_up_path_for(resource)
    edit_user_path(resource.id)
  end
  
  def after_sign_up_path_for(resource)
    edit_user_path(resource.id)
  end
# ~~~~ ~~~~

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :city, :email, :password, :password_confirmation, :current_password)}
  end

end
