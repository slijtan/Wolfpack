class CarrierFlight < ActiveRecord::Base

  belongs_to :carrier
  belongs_to :from, :foreign_key => :from_id, :class_name => "Airport"
  belongs_to :to, :foreign_key => :to_id, :class_name => "Airport"

  # time is stored in minutes
  def flight_duration
    (end_time_in_zone - start_time_in_zone) / 60
  end

  #flight creation factory
  def create_flight(user, trip, date)
    TripUser.create(:user => user, :trip => trip) unless TripUser.exists?(["user_id = ? AND trip_id = ?", user, trip])

    Flight.create(:user => user, :trip => trip, :carrier_flight => self, :seat_number => "16E", :date => date, :confirmation_number => "ASDF1234")
  end

  private

  def end_time_in_zone
    Time.use_zone(self.to.time_zone.name) do
      Time.zone.parse(Date.new(2000,1,1).to_s) + end_time.minutes
    end
  end

  def start_time_in_zone
    Time.use_zone(self.from.time_zone.name) do
      Time.zone.parse(Date.new(2000,1,1).to_s) + start_time.minutes
    end
  end
end
