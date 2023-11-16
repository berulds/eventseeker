class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    # authorize @bookmark # commented out till we decide if we pundit or not
  end
end
