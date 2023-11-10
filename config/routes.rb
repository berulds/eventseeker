Rails.application.routes.draw do
  get 'itineraries/new'
  devise_for :users
  root to: "pages#home"

  get 'events/new'
  get 'bookmarks/new'
end
