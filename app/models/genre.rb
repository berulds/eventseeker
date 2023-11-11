class Genre < ApplicationRecord
  belongs_to :event_genre
  has_many :users, through: :user_genres
end
