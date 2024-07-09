class OffersController < ApplicationController
  def index
    @offers = Offer.where(user: current_user)
  end

  def show
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.movie = Movie.find(params[:movie_id])
    @offer.name =  Movie.find(params[:movie_id]).title
    if @offer.save
      redirect_to offers_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to offers_path, status: :see_other
  end

  private

  def offer_params
    params.require(:offer).permit(:movie_id, :start_date, :end_date, :name)
  end
end
