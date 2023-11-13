class Event < ApplicationRecord
  has_one_attached :photo
  has_many :itinerary_events
  has_many :bookmarks
  has_many :event_genres, dependent: :destroy
  has_many :genres, through: :event_genres

  validates :name, :address, :start_time, :end_time, :description, presence: true
end
