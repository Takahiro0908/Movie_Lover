class Public::UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @movies =@user.movies
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to edit_user_path
  end

  def destroy
  end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
