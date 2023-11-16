Rails.application.routes.draw do

  devise_for :users

  root to: "pages#home"

  get '/search_events', to: 'pages#search_events', as: 'search_events'
  get 'itinerary_events/new'
  get 'pages/dashboard'
  get 'pages/about_us'

  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index] do
    resources :bookmarks, only: [:new, :create, :index]
  end
  resources :bookmarks, only: [:destroy, :show, :edit, :update]
  resources :itineraries, only: [:new, :create, :show, :destroy, :edit, :update]

end
