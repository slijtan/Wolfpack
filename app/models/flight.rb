class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :carrier_flight

  delegate :flight_duration, :start_time, :end_time, :from, :to, :to => :carrier_flight

  def minutes_since_trip_start
    (start_time_with_zone - Time.zone.parse(trip.start_date.to_s)) / 60
  end

  private

  def start_time_with_zone
    @date_time ||= Time.use_zone(self.from.time_zone.name) do
      Time.zone.local(self.date.year, self.date.month, self.date.day, start_absolute_hours, start_absolute_minutes)
    end
  end

  def start_absolute_hours
    start_time / 60
  end

  def start_absolute_minutes
    start_time % 60
  end
end
