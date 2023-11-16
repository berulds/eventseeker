class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy, :edit, :update]

  def index
    @events = Event.all
      # @events = policy_scope(Event)

  end

  def new
    @event = Event.new
    # authorize @event
  end

  def create
    @event = Event.new(event_params)
    # authorize @event
    @event.save
    redirect_to events_path
  end

  def show
    # authorize @event
  end

  def edit
    # authorize @event
  end

  def update
    @event.update(event_params)
    # authorize @event
    redirect_to root_path
  end

  def destroy
    @event.destroy
    # authorize @event
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
