class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flights do |t|
      t.integer :trip_id
      t.integer :user_id
      t.integer :carrier_flight_id
      t.string :seat_number
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :flights
  end
end
