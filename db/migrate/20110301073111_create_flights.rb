class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flights do |t|
      t.integer :trip_id, :null => false
      t.integer :user_id, :null => false
      t.integer :carrier_flight_id, :null => false
      t.string :seat_number
      t.string :confirmation_number, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :flights
  end
end
