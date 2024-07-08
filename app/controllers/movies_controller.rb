class MoviesController < ApplicationController
  before_action :set_user, only: %i[create]

  def new
    @movies = Movie.new
  end

  def show
    @movies = Movie.find(params[:id])
  end

  def create
    @movies = Movie.new(movie_params)
    @movie.user = @user
    if @movie.save
      redirect_to movie_list
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :poster_url, :status)
  end
end
