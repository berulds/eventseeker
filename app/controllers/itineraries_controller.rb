class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :destroy, :edit, :update]

  def index
    @itinerary = Itinerary.all
    @users = User.all
  end

  def new
    @itinerary = Itinerary.new
    # authorize @itinerary
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user
    # authorize @itinerary
    @itinerary.save
    redirect_to itinerary_path(@itinerary)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @itinerary_events = @itinerary.itinerary_events
    @markers = @itinerary_events.map do |itinerary_event|
      {
        lat: itinerary_event.event[:latitude],
        lng: itinerary_event.event[:longitude]
      }
    end
    # authorize @itinerary
  end

  def geocoded_events
    @itinerary_events.map do |itinerary_event|
      address = itinerary_event.event["address"]
      coordinates = ApiService.mapbox_geocode(address)
        {
          title: itinerary_event.event["title"],
          description: itinerary_event.event["description"],
          date: itinerary_event.event["date"]["start_date"],
          latitude: coordinates[:latitude],
          longitude: coordinates[:longitude]
        }
    end
  end

  def destroy
    @itinerary.destroy
    # authorize @itinerary
    redirect_to pages_dashboard_path, status: :see_other
  end

  def edit
    # authorize @itinerary
  end

  def update
    @itinerary.update(itinerary_params)
    # authorize @itinerary
    redirect_to itinerary_path(@itinerary)
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :start_time, :end_time)
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

end
