class ItineraryEventsController < ApplicationController

  def new
    @itinerary_event = ItineraryEvent.new
    # authorize @itinerary_event # commented out till we decide if we pundit or not
  end

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @event = Event.find(params[:event_id])
    @itinerary_event = ItineraryEvent.new(itinerary_id: @itinerary.id, event_id: @event.id)
    @itinerary_event.save
    redirect_to pages_dashboard_path
  end

end
