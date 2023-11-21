class ItineraryEventsController < ApplicationController

  def create
    if params[:query].present?
      @event = Event.find(params[:query])
      respond_to do |format|
        format.json { render json: @event } # Render JSON response
        format.html # Render HTML template
        end
    else
      @event = Event.find(params[:event_id])
    end
    @itinerary = Itinerary.find(params[:itinerary_id])
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
