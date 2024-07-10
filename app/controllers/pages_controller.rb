class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @movies = Movie.order(created_at: :desc).limit(10)
  end
end
