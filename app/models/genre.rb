class Genre < ApplicationRecord
  belongs_to :event_genre
  has_many :user_genre
end
