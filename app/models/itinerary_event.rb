class ItineraryEvent < ApplicationRecord
  belongs_to :itinerary
  belongs_to :event

  has_one :itinerary, dependent: :destroy
  has_one :event
end
