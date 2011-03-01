class CreateTripUsers < ActiveRecord::Migration
  def self.up
    create_table :trip_users do |t|
      t.integer :trip_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :trip_users
  end
end
