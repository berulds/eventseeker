class PagesController < ApplicationController
  before_action :set_user, :set_event
  skip_before_action :authenticate_user!, only: [ :home, :search_events ]

  def home

  end

  def search_events
    query = params[:query]
    location = params[:location]
    date = params[:date]
    @api_events = ApiService.call_google_events_api(query, location, date)
    render :home
  rescue StandardError => e
    @error_message = "Error occurred: #{e.message}"
    render :home
  end

  def dashboard
    @itinerary = Itinerary.all
    @bookmarks = current_user.bookmarks
  end

  def about_us

  end

  private

  def set_user
    @users = User.all
  end

  def set_event
    @events = Event.all
  end
end
