class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @bookmarks = Bookmark.all
    # @first_chatroom = @bookmarks.find { |bookmark| bookmark.event.chatroom.present? && bookmark.user }&.event&.chatroom.id
    events = @bookmarks.map(&:event)
    @bookmarking_users_by_event = {}

    events.each do |event|
      bookmarking_users = event.bookmarks.includes(:user).map(&:user)
      @bookmarking_users_by_event[event.id] = bookmarking_users
    end
  end

end
