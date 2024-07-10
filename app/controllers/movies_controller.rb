class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.search_by_title(params[:query])
    else
      @movies = Movie.all
    end
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save!
      redirect_to movie_path(@movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(params[:movie])
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def movie_params
    params.require(:movie).permit(:title, :overview, :poster_url, :status)
  end
end
