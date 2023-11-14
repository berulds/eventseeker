Rails.application.routes.draw do
  get 'itinerary_events/new'
  get 'itineraries/new'
  devise_for :users
  root to: "pages#home"
  get '/search_events', to: 'pages#search_events', as: 'search_events'
  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index]

  get 'bookmarks/new'
end
