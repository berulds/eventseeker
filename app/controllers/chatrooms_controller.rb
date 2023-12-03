class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @bookmarks = Bookmark.all
    # @first_chatroom = @bookmarks.find { |bookmark| bookmark.event.chatroom.present? && bookmark.user }&.event&.chatroom.id
  end

end
