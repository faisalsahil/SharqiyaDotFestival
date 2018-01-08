class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if @current_user_role == AppConstants::SUPER_ADMIN
      @users = User.all
    elsif @current_user_role == AppConstants::RESTAURANT
      @users = User.where(restaurant_id: current_user.restaurant_id)
    end
  end
  
  # def edit
  #   @user = User.find(params[:id])
  # end
  #
  # def update_user
  #   @user = User.find_by_id(params[:id])
  #   if @user.update(update_user_params)
  #     flash[:success] = 'User successfully updated.'
  #     redirect_to root_url
  #   else
  #     flash[:danger] = 'User already exist'
  #     redirect_to :back
  #   end
  # end
  
  def destroy
    if @user.present?
      if @user.is_deleted?
        @user.is_deleted = false
      else
        @user.is_deleted = true
      end
      @user.save(validate: false)
    end

    redirect_to users_path, notice: 'User was successfully destroyed.'
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :restaurant_branch_id)
  end
  
  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :restaurant_branch_id)
  end
end
