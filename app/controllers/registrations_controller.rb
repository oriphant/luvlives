class RegistrationsController < Devise::RegistrationsController

	# ~~~~Application Controller Code - Start ~~~~
  # ~~~ Not sure if I should move Devise code to from the Application Controller Registrations Controller ~~~
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :city, :email, :password, :password_confirmation, :current_password)}
  end
  # ~~~~ Application Controller Code - End ~~~~
	
	# protected # Make sure code below this is protected if move above code back to the Application Controller
  # Sets route for Devise after sign-in
  def after_sign_in_path_for(resource)
      questions_path(resource.id)
  end

	# Sets route for Devise after sign-up
  def after_sign_up_path_for(resource)
    confirmation_user_path(resource.id)
  end

  # ~~~~ CURRENTLY NOT BEING USED ~~~~
  # def after_inactive_sign_up_path_for(resource)
  #   confirmation_user_path(resource.id)
  # end
	# ~~~~ ~~~~  

end