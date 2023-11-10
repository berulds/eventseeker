class Itinerary < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :itinerary_events

  validates :start_time, :end_time, presence: true
end
