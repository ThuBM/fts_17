class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  include UsersHelper
  
  def index
    @users = User.without_user(current_user)
    @users = @users.paginate page: params[:page], per_page: 5
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id] 
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "User #{@user.username} has been updated"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    flash[:success] = "User #{user.username} has been deleted"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
  end
end