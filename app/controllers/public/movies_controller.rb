class Public::MoviesController < ApplicationController
  before_action :search_movie, only: [:index, :search]

  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @movie = Movie.new
  end

    # 投稿データの保存
  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def search
    @movie = Movie.find_by_id(params[:id])
    @results = @p.result
  end

  def index
    # @movies = Movie.page(params[:page])
    @genres = Genre.all
     if params[:genre_id]
      @movies = Movie.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
     else
      @movies = Movie.all.page(params[:page]).per(8)
     end

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

  def search_movie
    @p = Movie.ransack(params[:q])
  end

# 投稿データのストロングパラメータ
  private

  def movie_params
    params.require(:movie).permit(:title, :image, :body)
  end

end
