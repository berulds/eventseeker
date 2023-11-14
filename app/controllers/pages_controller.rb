class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search_events ]

  def home
    @users = User.all
    @events = Event.all
  end

  def search_events
    @users = User.all
    @events = Event.all
    query = params[:query]
    @api_events = ApiService.call_google_events_api(query)
    render :home
  rescue StandardError => e
    @error_message = "Error occurred: #{e.message}"
    render :home
  end
end
