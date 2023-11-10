class ItinerariesController < ApplicationController
  def new
    @itinerary = Itinerary.new
    authorize @itinerary
  end
end
