class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :itinerary_events, dependent: :destroy

  validates :name, :start_time, :end_time, presence: true
end
