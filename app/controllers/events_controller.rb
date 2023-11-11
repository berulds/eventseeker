class EventsController < ApplicationController
  before_action :set_event, only: [:destroy, :edit, :update]

  def new
    @event = Event.new
    authorize @event
  end

  def edit
    authorize @event
  end

  def update
    @event.update(event_params)
    authorize @event
    redirect_to root_path
  end

  def destroy
    @event.destroy
    authorize @event
    redirect_to root_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :start_time, :end_time, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
