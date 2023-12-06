class AddPhotoToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_reference :itineraries, :photo, foreign_key: { to_table: :active_storage_blobs }
  end
end
