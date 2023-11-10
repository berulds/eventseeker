class CreateItineraryEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :itinerary_events do |t|
      t.references :itinerary, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
