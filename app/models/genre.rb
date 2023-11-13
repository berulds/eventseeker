class Genre < ApplicationRecord
  has_one_attached :photo
  has_many :user_genres
  has_many :users, through: :user_genres
  has_many :event_genres
  has_many :events, through: :event_genres
end
