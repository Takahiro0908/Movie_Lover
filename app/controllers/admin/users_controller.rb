class Admin::UsersController < ApplicationController

  def index
    @user = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :status )
  end


end
