class ItineraryEventsController < ApplicationController
  def new
    @itinerary_event = ItineraryEvent.new
    authorize @itinerary_event
  end
end
