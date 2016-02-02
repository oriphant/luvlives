 class UsersController < ApplicationController
  before_action :authenticate_user!
  impressionist
  
  def edit
  end
  
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
    # @user = current_user
    @user = User.find(params[:id])
    # if @user.save
      # redirect_to questions_path
    # end
  end
 
   private 
   def user_params
     params.require(:user).permit(:name, :status, :bio, :city, :state, :gender, :age, :website, :facebook, :twitter, :linkedin, :avatar)
   end

 end