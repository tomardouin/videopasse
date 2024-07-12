class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.search_by_title_and_year(params[:query])
    else
      @movies = Movie.where(user: current_user)
    end
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @user = current_user
    @user_owner = @movie.user

    @markers = [{
        lat: @user.latitude,
        lng: @user.longitude,
        marker_html: render_to_string(partial: "marker")
      } , {
        lat: @user_owner.latitude,
        lng: @user_owner.longitude,
        marker_html: render_to_string(partial: "marker_2")
      }]

      if @user == @user_owner
        @markers = [{
          lat: @user.latitude,
          lng: @user.longitude,
          marker_html: render_to_string(partial: "marker_2")
        }]
      end
  end

  def list
    @movie = Movie.find(params[:id])
    @user = @movie.user
    @list = Movie.where(user: @movie.user)
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
    params.require(:movie).permit(:title, :overview, :poster_url, :genre_name)
  end
end
