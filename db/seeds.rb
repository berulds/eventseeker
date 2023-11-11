# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# require gem? add here
# require "uri"


# TODO
# [x] - create users (missing avatar logic for cloudinary)
# [x] - create genre
# [x] - create user_genres
# [ ] - create events
# [ ] - create event_genres
# [ ] - create bookmarks
# [ ] - create itineraries
# [ ] - create itinerary_events

puts 'Cleaning database'
User.destroy_all
Genre.destroy_all
UserGenre.destroy_all


# creating  users (with avatar picture (need to add a column to user/cloudinary))
# will change seed file to only cloudinary when project is more advanced( to avoid matt's paying to much!)
users_base = [
{username:"MattB", email:"matt@beruldsen.com", password:"qwerty123"},
{username:"AlexR", email:"alex@resnelis.com", password:"qwerty123"},
{username:"IsabelleL", email:"isabelle@lau.com", password:"qwerty123"},
{username:"EtienneF", email:"etienne@frechet.com", password:"qwerty123"},
{username:"JeanJeanJ", email:"jean@jean.com", password:"qwerty123"},
{username:"DwaineTherock", email:"dwayne@therock.com", password:"qwerty123"}
]

users_base.each do |user|
  user = User.create!(username: user[:username], email: user[:email], password: user[:password])
  filename = user.username + ".jpg"
  user.images.attach(io: File.open('app/assets/images/'+ filename), filename: filename)
end

# this is how to show the image on localhost/ view:
# declare  @avatar = current_user && add resize and border to image tag
# <%= image_tag @avatar.images.first if @user_avatar.images.attached? %>

puts "created #{User.count} users"


# feels like genre is too basic and we will struggle with search tool,
# we should add something like keyword column where we could add more specific
# like sports keywords = football, rugby, cricket.
# LETS leave it like this for now
genres_base = [
  { genre_type: "Music" },
  { genre_type: "Sports" },
  { genre_type: "Art" },
  { genre_type: "Food" },
  { genre_type: "ASMR" },
  { genre_type: "Technology" }
]

genres_base.each do |genre|
  Genre.create!(genre_type: genre[:genre_type])
end

puts "Created #{Genre.count} genres"


user_total = User.all

user_total.each do |user|
  UserGenre.create!(genre_id: Genre.all.sample.id, user_id: user.id)
end

puts "Created #{UserGenre.count} User_genres"
