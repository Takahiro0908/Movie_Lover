class Public::MoviesController < ApplicationController
  
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @movie = Movie.new
  end
  
    # 投稿データの保存
  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    @movie.save
    redirect_to movies_path
  end
  
  def index
    @movies = Movie.all
  end
  
  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: "successfully delete post!"
  end

# 投稿データのストロングパラメータ
  private

  def movie_params
    params.require(:movie).permit(:title, :image, :body)
  end

end
