class ItineraryEventsController < ApplicationController
  def new
    @itinerary_event = ItineraryEvent.new
    # authorize @itinerary_event # commented out till we decide if we pundit or not
  end
end
