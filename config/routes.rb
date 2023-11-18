Rails.application.routes.draw do

  devise_for :users

  root to: "pages#home"

  get '/search_events', to: 'pages#search_events', as: 'search_events'
  get 'bookmarks/new'
  get 'pages/dashboard'
  get 'pages/about_us'
  get 'events/index/itinerary_id'

  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index]
  resources :itineraries do
    resources :itinerary_events, only: [:new, :create]
  end
end

# send itinery params to index page at addto itinerary
# then get ID from controller. (if present get itinerary, if not go to events)
# if id is present create
