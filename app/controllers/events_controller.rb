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
    # authorize @event
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
      raise
      if @event.valid?
        if @event.save
          existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)

          unless existing_bookmark
            Bookmark.create(user_id: current_user.id, event_id: @event.id)
          end

          chatroom = Chatroom.create(name: "#{@event.name}", event: @event)

          render json: { status: "success", message: "Event saved successfully" }
        else
          render json: { status: "error", errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      else
        existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)

        unless existing_bookmark
          Bookmark.create(user_id: current_user.id, event_id: @event.id)
        end

        render json: { status: "success", message: "Event already added" }
      end
    end
# will refactor that later


  def show
    # authorize @event
  end

  def edit
    # authorize @event
  end

  def update
    @event.update(event_params)
    # authorize @event
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    # authorize @event
    redirect_to events_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :start_time, :end_time, :description, :photo, :ticket_purchase)
  end

  def event_params_api
    params.require(:event).permit(:name, :address, :start_time, :end_time, :description, :ticket_purchase)
  end

  def search_path_params
    params.permit(:query, :date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
