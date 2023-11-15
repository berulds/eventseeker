Rails.application.routes.draw do

  devise_for :users

  root to: "pages#home"

  get '/search_events', to: 'pages#search_events', as: 'search_events'
  get 'itinerary_events/new'
  get 'bookmarks/new'
  get 'pages/dashboard'
  get 'pages/about_us'

  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index]
  resources :itineraries, only: [:new, :create, :show, :destroy, :edit, :update]
end
