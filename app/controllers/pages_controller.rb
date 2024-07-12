class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home

    if params[:query].present?
      @movies = Movie.search_by_title_and_year(params[:query])
    else
      @movies = Movie.order(created_at: :desc).limit(10)
    end
  end
end
