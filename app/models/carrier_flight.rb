class CarrierFlight < ActiveRecord::Base

  belongs_to :carrier
  belongs_to :from, :foreign_key => :from_id, :class_name => "Airport"
  belongs_to :to, :foreign_key => :to_id, :class_name => "Airport"

  def flight_title
    "#{carrier.name} Flight ##{number}"
  end

  #flight creation factory
  def create_flight(user, trip, start_date, end_date)
    TripUser.create(:user => user, :trip => trip) unless TripUser.exists?(["user_id = ? AND trip_id = ?", user, trip])

    Flight.create(:user => user, :trip => trip, :carrier_flight => self, :seat_number => "16E", :start_date => start_date, :end_date => end_date, :confirmation_number => "ASDF1234")
  end
end
