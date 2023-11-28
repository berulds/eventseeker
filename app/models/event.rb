require 'open-uri'

class Event < ApplicationRecord
  has_one_attached :photo
  has_one :chatroom, dependent: :destroy
  has_many :itinerary_events
  has_many :bookmarks, dependent: :destroy
  has_many :event_genres, dependent: :destroy
  has_many :genres, through: :event_genres

  validates :name, :address, :start_time, :end_time, :description, presence: true

  def download_image_from_url(url)
    filename = File.basename(URI.parse(url).path)
    downloaded_image = URI.open(url)
    self.photo.attach(io: downloaded_image, filename: filename)
    end
end
