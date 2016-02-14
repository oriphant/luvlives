 class UsersController < ApplicationController
   before_action :authenticate_user!
  
  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to confirmation_user_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def confirmation
    @user = User.find(params[:id])
  end
 
   private 
   def user_params
     params.require(:user).permit(:name, :status, :bio, :city, :state, :gender, :age, :website, :facebook, :twitter, :linkedin, :avatar, :views, :provider, :uid)
   end

 end