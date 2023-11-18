class EventGenresController < ApplicationController
  def new
    @event_genre = EventGenre.new
    # authorize @event_genre
  end
end
