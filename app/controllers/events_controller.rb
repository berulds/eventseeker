class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy, :edit, :update]

  def index
    @events = Event.all
    if params[:itinerary_id].present?
      @itinerary = Itinerary.find(params[:itinerary_id])
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    chatroom = Chatroom.create(name: "#{@event.name}", event: @event)
    redirect_to events_path
    end

    def create_from_api
      event_params_api = {
        name: params["title"],
        address: params["address"].to_s,
        start_time: params['date']['start_date'],
        end_time: params['date']['start_date'],
        description: params["description"],
        ticket_purchase: params["ticket_info"].to_json,
        # add other thing like price etc...
      }

      @event = Event.new(event_params_api)
      @event.download_image_from_url(params["thumbnail"])

      if @event.valid?
        if @event.save
          existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)
          unless existing_bookmark
            Bookmark.create(user_id: current_user.id, event_id: @event.id)
          end
          chatroom = Chatroom.create(name: "#{@event.name}", event: @event)
        end
        existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)
        unless existing_bookmark
          Bookmark.create(user_id: current_user.id, event_id: @event.id)
        end
      end
    end

  def show
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path, status: :see_other
  end

  def check_event_exists
    name = params[:name]

    begin
      existing_event = Event.find_by(name: name)

      if existing_event
        render json: { exists: true }
      else
        render json: { exists: false }
      end
    rescue => e
      Rails.logger.error("Error checking event existence: #{e.message}")
      render json: { exists: false, error: e.message }, status: :internal_server_error
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :start_time, :end_time, :description, :photo, :ticket_purchase)
  end

  def event_params_api
    params.require(:event).permit(:name, :address, :start_time, :end_time, :description, :ticket_purchase)
  end

  def set_event
    @event = Event.find(params[:id]) if params[:id].present?
  end
end
