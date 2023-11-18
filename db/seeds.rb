# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# require gem? add here
require 'uri'

# TODO
# [x] - create users seeds (missing avatar logic for cloudinary)
# [x] - create genre seeds
# [x] - create user_genres seeds
# [x] - create events seeds
# [x] - create event_genres seeds
# [x] - create bookmarks seeds
# [x] - create itineraries seeds
# [x] - create itinerary_events seeds
# [ ] - implement cloudinary pictures with eco quality
        # Eco Quality
        # f_auto,q_auto:eco

puts 'Cleaning database...'
#make sure to delete in the right order, spent 10min on that....
User.destroy_all
Event.destroy_all
Genre.destroy_all
Itinerary.destroy_all
UserGenre.destroy_all
EventGenre.destroy_all
Bookmark.destroy_all
ItineraryEvent.destroy_all

puts 'Database clean'

# creating  users (with avatar picture (need to add a column to user/cloudinary))
# will change seed file to only cloudinary when project is more advanced( to avoid matt's paying to much!)
users_base = [
{ username:"MattB", email:"matt@beruldsen.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852072/rjz8iigryqclxvtrrqyg.jpg" },
{ username:"AlexR", email:"alex@resnelis.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852073/l2rtxwm4jwcn0oxgcn3d.jpg" },
{ username:"IsabelleL", email:"isabelle@lau.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852074/f9m6z2zma8kupcso7z7s.png" },
{ username:"EtienneF", email:"etienne@frechet.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852074/xcwfxgg3dibrpvpumic3.jpg" },
{ username:"JeanJeanJ", email:"jean@jean.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852073/kjr5egytj7rhdyszkpvs.webp" },
{ username:"DwaineTherock", email:"dwayne@therock.com", password:"qwerty123", photo_url:"https://res.cloudinary.com/di8qjnwgb/image/upload/v1699852073/xbqgilndltd1nl1re1jl.jpg" }
]

puts "Creating users..."

users_base.each do |user_params|
  user = User.new(username: user_params[:username], email: user_params[:email], password: user_params[:password])
  url = user_params[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    user.photo.attach(io: file, filename: filename, content_type: 'image/png')
  user.save
end

puts "Created #{User.count} users"


# feels like genre is too basic and we will struggle with search tool,
# we should add something like keyword column where we could add more specific
# like sports keywords = football, rugby, cricket.
# LETS leave it like this for now as we can just add line in pgsearch with different db tables

#generate genres seeds
genres_base = [
  { genre_type: "Music" },
  { genre_type: "Sports" },
  { genre_type: "Art" },
  { genre_type: "Food" },
  { genre_type: "ASMR" },
  { genre_type: "Technology" }
]

puts "Creating genres..."

genres_base.each do |genre|
  Genre.create!(genre_type: genre[:genre_type])
end

puts "Created #{Genre.count} genres"

puts "Creating user_genres..."

user_total = User.all #using this for bookmarks aswell

user_total.each do |user|
  UserGenre.create!(genre_id: Genre.all.sample.id, user_id: user.id)
end

puts "Created #{UserGenre.count} user_genres"

# generating ALL EVENTS, this is pretty heavy and DRY but I wanted this to be well detailed and not use faker
# will refactor later on
# create 5 music events seeds
music_events = [
  {
    name: "Australian Traditional Music Festival",
    address: "Sydney Opera House, Sydney, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "captivatie your world with the Australian traditional musics at the iconic Sydney Opera House. This festival is a celebration of the rich cultural tapestry of Australia,
    showcasing diverse musical traditions that have echoed through generations. From soul-stirring melodies to lively rhythms, experience the essence of Australian heritage through this spectacular
    music festival. Join us for a journey into the heart of tradition, where every note tells a story. Secure your tickets now to be part of this extraordinary celebration of Australia's musical legacy!",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857561/Music_australian_indegenous_wdkk7v.webp",
    ticket_purchase: "https://tickets.example.com/Australian-Traditional-Music-Festival"
  },

  {
    name: "The Strokes Finally in Melbourne!",
    address: "Melbourne Recital Centre, 31 Sturt St, Southbank VIC 3006, Australia",
    start_time: (Time.now + 96.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 100.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Get ready for a historic moment as The Strokes make their long-awaited debut in Melbourne! After 15 years,
    the iconic band is finally gracing the stage at the Melbourne Recital Centre. Immerse yourself in an unforgettable night of music, nostalgia,
    and raw energy as The Strokes deliver a performance that transcends time. Witness the magic of their legendary sound and experience the thrill of seeing them live for the first time in Melbourne.
    Secure your tickets now for a once-in-a-lifetime opportunity to be part of this momentous event!",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857567/Music_the_strokes_gqypuh.jpg",
    ticket_purchase: "https://tickets.example.com/The-Strokes-Finally-in-Melbourne!"
  },

  {
    name: "Dj Tiesto, Ultra Sidney",
    address: "Centennial Parklands Grand Dr, Centennial Park NSW 2021, Australia",
    start_time: (Time.now + 24.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 26.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Check these electrifying beats of DJ Tiesto at Ultra Sydney! Centennial Parklands will come alive with the pulsating rhythm of the finest European DJ,
    creating an unforgettable music festival experience. Get ready to dance the night away under the stars, surrounded by the vibrant energy of the crowd.
    Don't miss this opportunity to witness a musical journey curated by one of the world's most renowned DJs. Secure your spot now for an unforgettable night of electronic music excellence!",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857568/Music_ultra_tiesto_swl0jl.png",
    ticket_purchase: "https://tickets.example.com/australian-music-festival"
  },

  {
    name: "K-Pop Extravaganza",
    address: "Korean Cultural Centre Australia, 255 Elizabeth St, Sydney NSW 2000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Get ready for an electrifying night of K-Pop featuring your favorite artists and the hottest hits from the Korean music scene.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857560/Music_kpop_okl0jy.png",
    ticket_purchase: "https://tickets.example.com/kpop-extravaganza"
  },

  {
    name: "Symphony Orchestra playing Ghibli Studios Music",
    address: "Concert Hall, Sydney Opera House, Sydney, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Immerse yourself in the enchanting world of Studio Ghibli as the Symphony Orchestra brings its magical music to life.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857569/Music_Ghibli.jpg_nsrney.webp",
    ticket_purchase: "https://tickets.example.com/ghibli-orchestra-event"
  }
]

puts "Creating events....."

music_genre = Genre.find_by(genre_type: "Music")
music_events.each do |event|
  music_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase]
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    music_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  music_event.save

  EventGenre.create!(genre_id: music_genre.id, event_id: music_event.id)
end

# create 5 Sports events seeds
sport_events = [
  {
    name: "Australian Football final Adelaide Crows VS Brisbane Lions",
    address: "melbourne cricket ground, Brunton Ave, Richmond VIC 3002, Australia",
    start_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 75.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Get ready for the showdown of the season as the Australian Football final brings you a thrilling clash between two powerhouse teams - Adelaide Crows and Brisbane Lions!
    This epic battle is set to take place at the iconic Melbourne Cricket Ground",
    average_price: rand(50.0..150.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857567/Sport_final_zsyfyz.jpg",
    ticket_purchase: "https://tickets.example.com/Australian-Football-final-Adelaide-Crows-VS-Brisbane-Lions"
  },

  {
    name: "2026 BMX World Championships",
    address: "Degen Rd &, Mount Cotton Rd, Capalaba QLD 4157, Australia",
    start_time: (Time.now + 24.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 216.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Brisbane will welcome over 3,000 of the world's best BMX riders for the UCI BMX World Championships.
    Competition for male and female elite and junior events will run over 9 days. The event will be at Australia'’'s only Olympic standard BMX Supercross track,
    the Sleeman Sports Complex. The annual event was last held in Australia when Adelaide hosted in 2009.",
    average_price: rand(50.0..150.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857565/Sport_bmx_ihe2hj.png",
    ticket_purchase: "https://tickets.example.com/2026-BMX-World-Championships"
  },

  {
    name: "Australian Open Victoria © Tennis Australia",
    address: "Batman Ave, Melbourne VIC 3004, Australia",
    start_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 105.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "The Australian Open is a two-week tournament of tennis where the best players in the world gather to play at Melbourne Park
    during the last fortnight of January every year. The first of four Grand Slams in the annual tennis calendar",
    average_price: rand(50.0..150.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857573/Sport_tennis_open_ysazgu.jpg",
    ticket_purchase: "https://tickets.example.com/Australian-Open-Victoria-©-Tennis-Australia"
  },

  {
    name: "Surfest australia 2024",
    address: "73 James Paterson St, Anna Bay NSW 2316, Australia",
    start_time: (Time.now + 12.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 75.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Surfest Australia is the ultimate celebration of sun, sand, and surf! Join us for an exhilarating weekend of world-class surfing,
    where the best surfers from around the globe gather to showcase their skills on the breathtaking Australian waves.
    Feel the pulse of the ocean as seasoned professionals and rising stars compete for glory.",
    average_price: rand(50.0..150.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857559/Sport_Surf_p3w2yr.webp",
    ticket_purchase: "https://tickets.example.com/surfest"
  },

  {
    name: "Tri Nations Series Australia vs New Zealand",
    address: "Driver Ave, Moore Park NSW 2021, Australia",
    start_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 75.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Gear up for an exhilarating clash as the Tri Nations Series brings you a riveting match between two rugby powerhouses - Australia and New Zealand!
    The battlefield for this epic showdown is set at a yet-to-be-disclosed venue that promises an atmosphere of intense competition and sportsmanship",
    average_price: rand(50.0..150.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857558/Sport_trination_jklgkv.jpg",
    ticket_purchase: "https://tickets.example.com/Australia-New-Zealand-tri-nations"
  }
]

sports_genre = Genre.find_by(genre_type: "Sports")
sport_events.each do |event|
  sport_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase],
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    sport_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  sport_event.save

  EventGenre.create!(genre_id: sports_genre.id, event_id: sport_event.id)
end

# creating 5 arts events
art_events = [
  {
    name: "Melbourne International Film Festival",
    address: "Block Court, 290 Collins St, Melbourne VIC 3000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Experience the magic of cinema at the Melbourne International Film Festival, showcasing a diverse range of films from around the world.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857571/Art_film_festival_yrb31g.webp",
    ticket_purchase: "https://tickets.example.com/Melbourne-International-Film-Festival"
  },

  {
    name: "Sydney Opera House Ballet Gala",
    address: "Sydney Opera House, Bennelong Point, Sydney, New South Wales, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 50.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Immerse yourself in the elegance and grace of ballet as the Sydney Opera House hosts a spectacular gala featuring renowned ballet performances.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857570/Art_ballet_kblfhr.jpg",
    ticket_purchase: "https://tickets.example.com/Sydney-Opera-House-Ballet-Gala"
  },

  {
    name: "Vivid Sydney Light and Music Festival",
    address: "Circular Quay, Sydney, New South Wales, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Witness the city come alive with light and sound at Vivid Sydney, an annual festival celebrating the intersection of art, technology, and music.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857562/Art_vivid_qm0gs3.jpg",
    ticket_purchase: "https://tickets.example.com/Vivid-Sydney-Light-and-Music-Festival"
  },

  {
    name: "Adelaide Fringe Festival",
    address: "Rymill Park, Adelaide, South Australia, Australia",
    start_time: (Time.now + 24.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Join the vibrant atmosphere of the Adelaide Fringe Festival, where artists from all disciplines come together to showcase their talents in a dynamic and inclusive environment.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857564/image_a8vtrm.webp",
    ticket_purchase: "https://tickets.example.com/Adelaide-Fringe-Festival"
  },

  {
    name: "Brisbane Contemporary Art Exhibition",
    address: "Brisbane Powerhouse, 119 Lamington St, New Farm, Brisbane, Queensland, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 96.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Explore the cutting-edge of contemporary art at the Brisbane Contemporary Art Exhibition, featuring innovative works by local and international artists.",
    average_price: rand(20.0..100.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857565/Art_contemporary_texm8f.jpg",
    ticket_purchase: "https://tickets.example.com/Brisbane-Contemporary-Art-Exhibition"
  }
]

art_genre = Genre.find_by(genre_type: "Art")
art_events.each do |event|
  art_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase],
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    art_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  art_event.save

  EventGenre.create!(genre_id: art_genre.id, event_id: art_event.id)
end

# create 5 Food events
food_events = [
  {
    name: "Melbourne Food Festival",
    address: "Federation Square, Melbourne VIC 3000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Indulge in a culinary extravaganza at the Melbourne Food Festival, featuring a diverse array of cuisines and culinary experiences.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857559/Food_food_festival_oifkmn.jpg",
    ticket_purchase: "https://tickets.example.com/Melbourne-Food-Festival"
  },

  {
    name: "Sydney Seafood Spectacular",
    address: "Sydney Fish Market, Pyrmont, Sydney, New South Wales, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 50.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Dive into a sea of flavors at the Sydney Seafood Spectacular, celebrating the best of Australia's seafood at the iconic Sydney Fish Market.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857562/Food_sidney_fish_nxhwgs.jpg",
    ticket_purchase: "https://tickets.example.com/Sydney-Seafood-Spectacular"
  },

  {
    name: "Brisbane Street Food Fest",
    address: "South Bank Parklands, Brisbane, Queensland, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Savor the eclectic flavors of street food at the Brisbane Street Food Fest, where food trucks and stalls converge for a gastronomic adventure.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857572/Food_street_food_gnaqaa.jpg",
    ticket_purchase: "https://tickets.example.com/Brisbane-Street-Food-Fest"
  },

  {
    name: "Adelaide Wine and Dine Expo",
    address: "Adelaide Convention Centre, North Terrace, Adelaide, South Australia, Australia",
    start_time: (Time.now + 24.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Experience the perfect pairing of wine and culinary delights at the Adelaide Wine and Dine Expo, a showcase of the region's finest offerings.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857569/Food_adelaide_bnqhbz.jpg",
    ticket_purchase: "https://tickets.example.com/Adelaide-Wine-and-Dine-Expo"
  },

  {
    name: "Perth Gourmet Food Fair",
    address: "Elizabeth Quay, Perth, Western Australia, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 96.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Tantalize your taste buds at the Perth Gourmet Food Fair, featuring a showcase of gourmet dishes, local produce, and culinary innovations.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857564/Food_perth_xnpfgf.jpg",
    ticket_purchase: "https://tickets.example.com/Perth-Gourmet-Food-Fair"
  }
]

food_genre = Genre.find_by(genre_type: "Food")
food_events.each do |event|
  food_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase],
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    food_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  food_event.save

  EventGenre.create!(genre_id: food_genre.id, event_id: food_event.id)
end

# create 5 Technology events
technology_events = [
  {
    name: "CodeCon 2023",
    address: "Melbourne Convention and Exhibition Centre, 1 Convention Centre Pl, South Wharf VIC 3006, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Join the largest coding conference in Australia, CodeCon 2023, for a deep dive into the latest technologies, coding trends, and networking with fellow developers.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857563/Tech_codecon_y9zqmo.jpg",
    ticket_purchase: "https://tickets.example.com/CodeCon-2023"
  },

  {
    name: "Apple Showcase 2023",
    address: "Sydney International Convention Centre, 14 Darling Dr, Sydney NSW 2000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 50.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Be the first to witness the latest innovations from Apple at the Apple Showcase 2023, where cutting-edge products and technologies will be unveiled.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857559/Tech_apple_zojg2g.jpg",
    ticket_purchase: "https://tickets.example.com/Apple-Showcase-2023"
  },

  {
    name: "Tech StartUp Expo",
    address: "Brisbane Convention & Exhibition Centre, Merivale St, South Brisbane QLD 4101, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Explore the future of technology at the Tech StartUp Expo, where groundbreaking startups showcase their innovations, and industry experts share insights.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857558/Tech_startup_expo_lm1r2n.png",
    ticket_purchase: "https://tickets.example.com/Tech-StartUp-Expo"
  },

  {
    name: "AI and Robotics Symposium",
    address: "Adelaide Convention Centre, North Terrace, Adelaide, South Australia, Australia",
    start_time: (Time.now + 24.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Dive into the world of Artificial Intelligence and Robotics at the Symposium, where experts share groundbreaking research and advancements in AI and robotics.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857560/Tech_ai_tlfmdw.jpg",
    ticket_purchase: "https://tickets.example.com/AI-and-Robotics-Symposium"
  },

  {
    name: "Virtual Reality Expo",
    address: "Perth Convention and Exhibition Centre, 21 Mounts Bay Rd, Perth WA 6000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 96.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Immerse yourself in the future of Virtual Reality at the Virtual Reality Expo, where the latest VR technologies and experiences are showcased.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..50.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857571/Tech_VR_ygs9tx.jpg",
    ticket_purchase: "https://tickets.example.com/Virtual-Reality-Expo"
  }
]

technology_genre = Genre.find_by(genre_type: "Technology")
technology_events.each do |event|
  technology_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase],
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    technology_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  technology_event.save

  EventGenre.create!(genre_id: technology_genre.id, event_id: technology_event.id)
end

# create ASMR events
asmr_events = [
  {
    name: "Whispering Waves ASMR Experience",
    address: "Tranquil Retreat, 42 Serenity Lane, Oceanfront, VIC 3000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 72.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Immerse yourself in the soothing world of ASMR with the Whispering Waves ASMR Experience. Let the calming whispers and gentle sounds transport you to a state of relaxation.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..30.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857570/ASMR_first_iht77v.png",
    ticket_purchase: "https://tickets.example.com/Whispering-Waves-ASMR-Experience"
  },

  {
    name: "ASMR Soundscape Retreat",
    address: "Tranquil Haven, 28 Peaceful Path, Serenityville, NSW 2000, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 50.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Embark on a sensory journey at the ASMR Soundscape Retreat. Delight in the harmonious blend of calming sounds and gentle whispers for a truly tranquil experience.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..30.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857571/ASMR_second_piinv2.jpg",
    ticket_purchase: "https://tickets.example.com/ASMR-Soundscape-Retreat"
  },

  {
    name: "Zen Garden ASMR Night",
    address: "Peaceful Oasis, 15 Zen Way, Harmonyville, QLD 4101, Australia",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 52.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Experience tranquility at the Zen Garden ASMR Night. Let the ASMR artists guide you through a night of calming sounds and gentle triggers in a serene garden setting.",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..30.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857561/ASMR_third_idt391.jpg",
    ticket_purchase: "https://tickets.example.com/Zen-Garden-ASMR-Night"
  },

  {
    name: "Alex Keyboard and Inspire9 ASMR",
    address: "Level 1/41-43 Stewart St, Richmond VIC 3121, Australia",
    start_time: (Time.now + 1.hours).strftime("%Y-%m-%d %H:%M:%S"),
    end_time: (Time.now + 50.hours).strftime("%Y-%m-%d %H:%M:%S"),
    description: "Embark on a sensory journey @ LeWagon bootcamp with Alex as he demonstrates how many differents sounds he can produce with just his boday and computer.
    Some people says that you never truly experience inner peace before hearing Alexis'magic fingers...",
    average_price: rand(2) == 0 ? "FREE" : rand(10.0..30.0).round(2),
    photo_url: "https://res.cloudinary.com/di8qjnwgb/image/upload/v1699857568/ASMR_Alex_s1ruai.jpg",
    ticket_purchase: "https://tickets.example.com/Alex-Keyboard-and-background-ASMR"
  }
]

asmr_genre = Genre.find_by(genre_type: "ASMR")
asmr_events.each do |event|
  asmr_event = Event.new(
    name: event[:name],
    address: event[:address],
    start_time: event[:start_time],
    end_time: event[:end_time],
    description: event[:description],
    average_price: event[:average_price],
    ticket_purchase: event[:ticket_purchase],
  )

  url = event[:photo_url]
    file = URI.open(url)
    filename = File.basename(url)
    asmr_event.photo.attach(io: file, filename: filename, content_type: 'image/png')
  asmr_event.save

  EventGenre.create!(genre_id: asmr_genre.id, event_id: asmr_event.id)
end

puts "Created #{Event.count} events"

# creating bookmarks seeds
puts "Creating bookmarks..."

events = Event.all
user_total.each do |user|
  5.times do
    event = events.sample
    unless Bookmark.exists?(user_id: user.id, event_id: event.id)
      Bookmark.create!(user_id: user.id, event_id: event.id, status: :interested)
    end
  end
end

puts "Created #{Bookmark.count} bookmarks"


# creating itinerary seeds
puts "Creating itineries..."

user_total.each do |user|
  itinerary = Itinerary.create!(
    name: "#{user.username}'s vacation plan",
    start_time: (Time.now + 48.hours).strftime("%Y-%m-%d %H:%M:%S"),
    user_id: user.id,
    end_time: (Time.now + 120.hours).strftime("%Y-%m-%d %H:%M:%S"))

  5.times do
    random_event = Event.all.sample

    if (itinerary.start_time..itinerary.end_time).cover?(random_event.start_time) &&
      (itinerary.start_time..itinerary.end_time).cover?(random_event.end_time)
      ItineraryEvent.create!(itinerary_id: itinerary.id, event_id: random_event.id)
    end
  end
end

puts "Created #{Itinerary.count} itineraries & #{ItineraryEvent.count} event itineraries"
