# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"
@user = User.create(username: 'test', email: 'test@testmail.com', password: '123456')
Movie.destroy_all
apiurl = "https://tmdb.lewagon.com/movie/top_rated"
top_rated = URI.open(apiurl).read
movies = JSON.parse(top_rated)

movies["results"].each do |m|
  poster_path = m["poster_path"]
  Movie.create!(title: m["title"],
    overview: m["overview"],
    release_year: m["release_year"],
    poster_url: "https://image.tmdb.org/t/p/w500#{poster_path}",
    user: User.first
  )
end
puts "tout va bien"
