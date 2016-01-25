class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include Pundit
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to questions_path, alert: exception.message
  end

  protected
  # Sets route for Devise after sign-in --> This needs to stay in application controller
  def after_sign_in_path_for(resource)
      questions_path(resource.id)
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :city, :bio, :email, :password, :password_confirmation, :current_password)}
  # end

end
