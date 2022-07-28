class Public::FavoritesController < ApplicationController
before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.new(movie_id: @movie.id)
    @favorite.save
  # redirect_to movie_path(movie) 非同期通信のため削除

  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    @favorite.destroy
  # redirect_to movie_path(movie)  非同期通信のため削除
  end
end
