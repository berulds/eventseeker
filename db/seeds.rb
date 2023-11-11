# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# require "uri"


# TODO
# [x] - create users (missing avatar logic)
# [x] - create genre
# [ ] - create user_genres
# [ ] - create events
# [ ] - create event_genres
# [ ] - create bookmarks
# [ ] - create itineraries
# [ ] - create itinerary_events

puts 'Cleaning database'
User.destroy_all


# creating  users (with avatar picture (need to add a column to user/cloudinary))
users_base = [
{username:"MattB", email:"matt@beruldsen.com", password:"qwerty123"},
{username:"AlexR", email:"alex@resnelis.com", password:"qwerty123"},
{username:"IsabelleL", email:"isabelle@lau.com", password:"qwerty123"},
{username:"EtienneF", email:"etienne@frechet.com", password:"qwerty123"},
{username:"JeanJeanJ", email:"jean@jean.com", password:"qwerty123"},
{username:"DwaineTherock", email:"dwayne@therock.com", password:"qwerty123"}
]

users_base.each do |user|
  User.create!(username: user[:username], email: user[:email], password: user[:email])
end

puts "created #{User.count} users"


# feels like genre is too basic and we will struggle with search tool,
# we should add something like keyword column where we could add more specific
# like sports keywords = football, rugby, cricket
genres_base = [
  { name: "Music" },
  { name: "Sports" },
  { name: "Art" },
  { name: "Food" },
  { name: "Technology" }
]

genres_base.each do |genre|
  Genre.create!(name: genre[:name])
end

puts "Created #{Genre.count} genres"
