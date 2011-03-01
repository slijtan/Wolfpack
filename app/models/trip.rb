class Trip < ActiveRecord::Base
  has_many :users, :through => :trip_users
  has_many :trip_users, :dependent => :destroy
  has_many :flights
end
