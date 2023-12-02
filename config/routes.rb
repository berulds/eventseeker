Rails.application.routes.draw do

  devise_for :users

  root to: "pages#home"

  get '/search_events', to: 'pages#search_events', as: 'search_events'
  get '/see_more', to: 'pages#see_more', as: 'see_more'
  get 'bookmarks/new'
  get 'pages/dashboard'
  get 'pages/about_us'
  post 'create_from_api', to: 'events#create_from_api', as: 'create_from_api'
  get '/events/check_event_exists', to: 'events#check_event_exists', as: 'check_event_exists'


  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index] do
    resources :bookmarks, only: [:new, :create, :index, :update]
  end
  resources :bookmarks, only: [:destroy, :show, :edit, :update]
  resources :itineraries do
    resources :itinerary_events, only: [:new, :create]
  end
  resources :itinerary_events, only: [:destroy]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
