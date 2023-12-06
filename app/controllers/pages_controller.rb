class PagesController < ApplicationController
  before_action :set_user, :set_event, :set_query, :set_date
  skip_before_action :authenticate_user!, only: [ :home, :search_events ]
  before_action :authenticate_user!, only: [:save_from_api]

  def home

  end

  def search_events
    store_location_for(:user, request.fullpath) # for login logic if not signed in
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
    render :home
  rescue StandardError => e
    @error_message = "Error occurred: #{e.message}"
    render :home
  end

  def dashboard
    @bookmarks = current_user.bookmarks.includes(event: :chatroom)
    @itinerary = current_user.itineraries
    @first_chatroom = @bookmarks.find { |bookmark| bookmark.event&.chatroom.present? && bookmark.user }&.event&.chatroom&.id

  events = @bookmarks.map(&:event)
  @bookmarking_users_by_event = {}
  events.each do |event|
    bookmarking_users = event.bookmarks.includes(:user).map(&:user)
    @bookmarking_users_by_event[event.id] = bookmarking_users
  end

    @bookmarks.each do |bookmark|
      update_status_with_time(bookmark)
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
