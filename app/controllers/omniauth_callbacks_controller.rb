class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user
      set_flash_message(:notice, :success, :kind => "Facebook")if is_navigational_format?
      # notice: "Signed in!"
    else
    	session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect user 
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

   def linkedin 
    auth = env["omniauth.auth"] 
    user = User.find_for_linkedin(request.env["omniauth.auth"],current_user) 
    if user.persisted? 
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Linked-In"
      sign_in_and_redirect user
    else 
      session["devise.linkedin_uid"] = request.env["omniauth.auth"] 
      redirect_to new_user_registration_url 
    end
  end

  def failure
    redirect_to root_path
  end
  
end