class CreateAirports < ActiveRecord::Migration
  def self.up
    create_table :airports do |t|
      t.string :airport_code
      t.string :full_name
    end
  end

  def self.down
    drop_table :airports
  end
end
