class CreateTrips < ActiveRecord::Migration
  def self.up
    create_table :trips do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :trips
  end
end
