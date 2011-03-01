class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :carrier_flight
end
