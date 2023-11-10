class EventsController < ApplicationController
  def new
    @event = Event.new
    authorize @event
  end
end
