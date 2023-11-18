class BookmarksController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :set_bookmark, only: [:destroy]

  def index
    @bookmarks = current_user.bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    # you are only able to create bookmark if you dont have a bookmark already on this event
    existing_bookmark = Bookmark.find_by(user_id: current_user.id, event_id: @event.id)

    if existing_bookmark.nil?
      @bookmark = Bookmark.new(user_id: current_user.id, event_id: @event.id, attending: true)

      if @bookmark.save
        redirect_to events_path, notice: 'Bookmark created successfully.'
      else
        redirect_to events_path, alert: 'Failed to create bookmark.'
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @bookmark.destroy
    redirect_to event_bookmarks_path(current_user), status: :see_other, notice: 'Bookmark deleted successfully.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :attending)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

end


# bookmark should be a button on events card
# basic logic would only be attending ( we could add interested as a dropdown?)
# that would simplify logic for user and for us (just toggling between attending/interested/attended/delete)
