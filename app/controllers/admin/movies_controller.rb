class Admin::MoviesController < ApplicationController
  before_action :search_movie, only: [:index, :search]

  def index
    @movies = Movie.page(params[:page])
    # @p = Movie.ransack(params[:q])
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
  end


  def search_movie
    @p = Movie.ransack(params[:q])
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admin_movies_path, notice: "successfully delete post!"
  end


end
