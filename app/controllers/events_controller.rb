class EventsController < ApplicationController
  def new
    @event = Event.new
    authorize @event
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end
end
