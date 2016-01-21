 class UsersController < ApplicationController
   before_action :authenticate_user!

  def edit
  end
  
  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def confirmation
    @user = current_user
  end
 
   private
 
   def user_params
     params.require(:user).permit(:name)
   end
 end