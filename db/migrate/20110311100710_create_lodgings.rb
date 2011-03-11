class CreateLodgings < ActiveRecord::Migration
  def self.up
    create_table :lodgings do |t|
      t.references :trip, :null => false
      t.references :hotel, :null => false
      t.date :check_in_date, :null => false
      t.date :check_out_date
      t.integer :check_in_time
      t.integer :check_out_time

      t.timestamps
    end
  end

  def self.down
    drop_table :lodgings
  end
end
