class ItineraryEvent < ApplicationRecord
  belongs_to :itinerary
  belongs_to :event
end
