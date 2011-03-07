class CreateTimeZones < ActiveRecord::Migration
  def self.up
    create_table :time_zones do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :time_zones
  end
end
