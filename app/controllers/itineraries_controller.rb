class ItinerariesController < ApplicationController
  def new
    @itinerary = Itinerary.new
    authorize @itinerary
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    authorize @itinerary
    @itinerary.save
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
  end

  def destroy
    @itinerary.destroy
    authorize @itinerary
    redirect_to root_path, status: :see_other
  end

  def edit
    authorize @itinerary
  end

  def update
    @itinerary.update(itinerary_params)
    authorize @itinerary
    redirect_to root_path
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :start_time, :end_time)
  end

end
