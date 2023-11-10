Rails.application.routes.draw do
  get 'itinerary_events/new'
  get 'itineraries/new'
  devise_for :users
  root to: "pages#home"

  get 'events/new'
  get 'bookmarks/new'
end
