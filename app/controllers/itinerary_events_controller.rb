class ItineraryEventsController < ApplicationController

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @event = Event.find(params[:event_id])
    @itinerary_event = ItineraryEvent.new(itinerary_id: @itinerary.id, event_id: @event.id)
    @itinerary_event.save
    redirect_to itinerary_path(@itinerary)
  end

  def destroy
    @itinerary_event = ItineraryEvent.find(params[:id])
    @itinerary_event.destroy
    @itinerary = Itinerary.find(params[:itinerary_id])
    redirect_to itinerary_path(@itinerary)
  end

end
