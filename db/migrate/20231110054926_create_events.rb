class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.timestamp :start_time
      t.timestamp :end_time
      t.float :longitude
      t.float :latitude
      t.string :description
      t.string :category
      t.string :average_price
      t.string :ticket_purchase

      t.timestamps
    end
  end
end
