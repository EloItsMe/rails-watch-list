class MoviesController < ApplicationController
  # before_action :set_params, only: %i[show edit update destroy chef]

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @new_movie = Movie.new
  end

  def create
    @new_movie = Movie.new(set_params)
    if @new_movie.save!
      redirect_to movie_path(@new_movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_params
    params.require(:movie).permit(:title, :overview, :poster_url, :rating)
  end
end
