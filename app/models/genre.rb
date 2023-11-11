class Genre < ApplicationRecord
  belongs_to :event_genre
  has_many :user_genre
  has_many :users, through: :user_genre
end
