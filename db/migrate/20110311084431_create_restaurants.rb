class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name, :null => false
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :url
      t.string :photo_url
      t.string :map_url
      t.string :yelp_url
    end
  end

  def self.down
    drop_table :restaurants
  end
end
