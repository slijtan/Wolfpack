class CreateHotels < ActiveRecord::Migration
  def self.up
    create_table :hotels do |t|
      t.string :name, :null => false
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :url
      t.string :photo_url
      t.string :map_url
    end
  end

  def self.down
    drop_table :hotels
  end
end
