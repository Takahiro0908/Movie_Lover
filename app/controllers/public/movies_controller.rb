class Public::MoviesController < ApplicationController
  before_action :search_movie, only: [:index, :search]
  require 'themoviedb-api'
  Tmdb::Api.key("d172e3134504081346e78aaedb5d7059")
  Tmdb::Api.language("ja") # こちらで映画情報の表示の際の言語設定を日本語にできます

  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @movie = Movie.new
  end

    # 投稿データの保存
  def create
    @movie = Movie.new(movie_params)
    #投稿した本文をAPIに渡す
    @movie.score = Language.get_data(movie_params[:body])  #この行を追加

    @movie.user_id = current_user.id
    if @movie.save
      #VisionAPIの呼び出し
      tags = Vision.get_image_data(@movie.image)
      tags.each do |tag|
        @movie.tags.create(name: tag)
      end
      redirect_to movies_path
    else
      render :new
    end
  end

  def search
    @movie = Movie.find_by_id(params[:id])
    @results = @p.result
  end

  def search_tmdb
    # 一旦moviedataという変数にアウトプットを格納
    # @tmdb_movies = JSON.parse((Tmdb::Search.movie(params[:title])).to_json)
    # ここで検索結果を表示

    # 検索結果ビュ-のリンクから下のパスに飛ぶ
    # new_movie_path(title:tmdb_movie_title)
  end

  def detail

  end

  def index
    @movie = Movie.find(params[:id])
    @genres = Genre.all
     if params[:genre_id]
      @movies = Movie.where(genre_id: params[:genre_id]).page(params[:page]).per(6)
     else
      @movies = Movie.all.page(params[:page]).per(6)
     end

  end

  def show
    @movie = Movie.find(params[:id])
    @genre = Genre.find(@movie.genre_id)
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
    params.require(:movie).permit(:title, :image, :body, :genre_id)
  end

end
