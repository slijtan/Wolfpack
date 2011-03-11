class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.integer :trip_id, :null => false
      t.integer :user_id, :null => false
      t.integer :restaurant_id, :null => false
      t.date :date, :null => false
      t.integer :start_time, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
