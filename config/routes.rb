Rails.application.routes.draw do
  get 'itinerary_events/new'
  get 'itineraries/new'
  devise_for :users
  root to: "pages#home"

  resources :events, only: [:new, :show, :create, :destroy, :edit, :update, :index]

  get 'bookmarks/new'

end
