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
    # authorize @itinerary
  end

  def destroy
    @itinerary.destroy
    # authorize @itinerary
    redirect_to root_path, status: :see_other
  end

  def edit
    # authorize @itinerary
  end

  def update
    @itinerary.update(itinerary_params)
    # authorize @itinerary
    redirect_to root_path
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :start_time, :end_time)
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

end
