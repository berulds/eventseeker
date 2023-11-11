class Genre < ApplicationRecord
  has_many :user_genre
  has_many :users, through: :user_genre
end
