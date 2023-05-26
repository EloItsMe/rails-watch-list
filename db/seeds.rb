# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

movies = JSON.parse(URI.open("http://tmdb.lewagon.com/movie/top_rated").read)["results"]

puts "\n[DELETE BOOKMARK DATABASE...]"
Bookmark.destroy_all

puts "[DELETE MOVIES DATABASE...]"
Movie.destroy_all

puts "\n[DELETE LISTS DATABASE...]"
List.destroy_all



puts "\n[CREATE 20 MOVIES]\n\n"

movies.each do |movie|
  new_movie = Movie.new(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  new_movie.save!
  puts "- [ADD #{new_movie.title} TO MOVIES]"
end
puts "\n[FINISH]\n\n"
