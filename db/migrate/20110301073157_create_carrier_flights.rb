class CreateCarrierFlights < ActiveRecord::Migration
  def self.up
    create_table :carrier_flights do |t|
      t.integer :carrier_id
      t.string :number
      t.integer :from_id
      t.integer :to_id
      t.integer :start_time #in minutes from midnight
      t.integer :end_time
    end
  end

  def self.down
    drop_table :carrier_flights
  end
end
