class CreateUserLodgings < ActiveRecord::Migration
  def self.up
    create_table :user_lodgings do |t|
      t.references :user
      t.references :lodging

      t.timestamps
    end
  end

  def self.down
    drop_table :user_lodgings
  end
end
