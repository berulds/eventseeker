class PagesController < ApplicationController
  before_action :set_user, :set_event, :set_query, :set_date
  skip_before_action :authenticate_user!, only: [ :home, :search_events ]

  def home

  end

  def search_events
    # location = params[:location]
    # matched_address = location.match(/^([^,]+).*?([^,]+)\s*$/)
    # clean_location = location.include?(',') ? matched_address[1] + matched_address[2] : location
    if params[:start].present?
      counter = params[:start]
    else
      counter = 0
    end
    @api_events = ApiService.call_google_events_api(@query, @date, counter)
    render json: api_events

    @geocoded_events = geocoded_events
    @markers = @geocoded_events.map do |event|
      {
        lat: event[:latitude],
        lng: event[:longitude]
      }
    end
    render :home
  rescue StandardError => e
    @error_message = "Error occurred: #{e.message}"
    render :home
  end

  def dashboard
    @bookmarks = current_user.bookmarks.includes(event: :chatroom)
    @itinerary = current_user.itineraries
    # @chatrooms = ???
    @bookmarks.each do |bookmark|
      update_status_with_time(bookmark)
    end
  end

  def geocoded_events
    @api_events.map do |event|
      address = event["address"]
      coordinates = ApiService.mapbox_geocode(address)
        {
          title: event["title"],
          description: event["description"],
          date: event["date"]["start_date"],
          latitude: coordinates[:latitude],
          longitude: coordinates[:longitude]
        }
    end
  end

  def about_us
  end

  private

  def update_status_with_time(bookmark)
    bookmark.update(status: "attended") if bookmark.event.end_time < Time.now && bookmark.status == "attending"
    bookmark.update(status: "event is already past") if bookmark.event.end_time < Time.now && bookmark.status == "interested"
  end

  def set_user
    @users = User.all
  end

  def set_event
    @events = Event.all
  end

  def set_query
    @query = params[:query]
  end

  def set_date
    @date = params[:date]
  end
end
