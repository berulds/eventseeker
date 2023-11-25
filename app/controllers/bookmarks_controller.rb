class BookmarksController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :set_bookmark, only: [:destroy, :update]

  def index
    @bookmarks = current_user.bookmarks
    @itinerary = Itinerary.all

    @bookmarks.each do |bookmark|
      update_status_with_time(bookmark)
    end
  end

  def create
    existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)

    if existing_bookmark.nil?
      @bookmark = Bookmark.new(user_id: current_user.id, event_id: @event.id)

      if @bookmark.save
        redirect_to events_path, notice: 'Bookmark created successfully.'
      else
        redirect_to events_path, alert: 'Failed to create bookmark.'
      end
    end
  end

  def update
    @bookmark.update(status: "attending")
    redirect_to pages_dashboard_path(current_user), status: :see_other, notice: 'Bookmark Updated successfully.'
  end

  def destroy
    @bookmark.destroy
    redirect_to pages_dashboard_path(current_user), status: :see_other, notice: 'Bookmark deleted successfully.'
  end


  private


  def update_status_with_time(bookmark)
    bookmark.update(status: "attended") if bookmark.event.end_time < Time.now && bookmark.status == "attending"
    bookmark.update(status: "event is already past") if bookmark.event.end_time < Time.now && bookmark.status == "interested"
  end

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :status)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

end
