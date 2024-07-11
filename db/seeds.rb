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

Movie.destroy_all

def genre_strings(movie_genres_ids)
  movie_genres = []
  movie_genres_ids.each do |i|
    genre = case i
      when 28 then 'Action'
      when 12 then 'Adventure'
      when 16 then 'Animation'
      when 35 then 'Comedy'
      when 80 then 'Crime'
      when 99 then 'Documentary'
      when 18 then 'Drama'
      when 10751 then 'Family'
      when 14 then 'Fantasy'
      when 36 then 'History'
      when 27 then 'Horror'
      when 10402 then 'Music'
      when 9648 then 'Mystery'
      when 10749 then 'Romance'
      when 878 then 'Science Fiction'
      when 10770 then 'TV Movie'
      when 53 then 'Thriller'
      when 10752 then 'War'
      when 37 then 'Western'
    else 'Porn'
    end
    movie_genres << genre
  end
  movie_genres
end

@user = User.create(username: 'test', email: 'test@testmail.com', password: '123456')
apiurl = "https://tmdb.lewagon.com/movie/top_rated"
top_rated = URI.open(apiurl).read
movies = JSON.parse(top_rated)


movies["results"].each do |m|
  poster_path = m["poster_path"]
  Movie.create!(title: m["title"],
    overview: m["overview"],
    release_year: m["release_year"],
    poster_url: "https://image.tmdb.org/t/p/w500#{poster_path}",
    user: User.first,
    genre_name: genre_strings(m["genre_ids"])
  )
end
puts "tout va bien"
