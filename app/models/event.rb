class Event < ApplicationRecord
  has_one :photo
  has_many :bookmarks

  validates :name, :address, :start_time, :end_time, :description, presence: true
end
