class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  #ユーザーの編集画面へのURLを直接入力された場合にはメッセージを表示してユーザー詳細画面へリダイレクト
  before_action :ensure_guest_user, only: [:edit]

  def index
    @user = User.all
    @movies = current_user.movies.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @movies =@user.movies.page(params[:page]).per(6)
    # favorites= Favorite.where(user_id: @user.id).pluck(:movie_id)
    # @favorite_movies = Movie.find(favorites)

  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to edit_user_path
  end

  def destroy
  end

  def check
    @user = User.find(params[:id])
    #ユーザーの情報を見つける
  end

  def withdrawl
    @user = User.find(current_user.id)
    #現在ログインしているユーザーを@userに格納
    @user.update(status: false)
    #updateで登録情報をInvalidに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    #指定されたrootへのpath
  end

  def favorites
    @user = User.find(params[:id])
    @movies =@user.movies.page(params[:page]).per(6)
    favorites= Favorite.where(user_id: @user.id).pluck(:movie_id)
    @favorite_movies = Movie.find(favorites)
  end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image, :status)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
