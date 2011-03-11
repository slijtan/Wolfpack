class TripEvent
  attr_reader :start_time, :end_time, :date, :users, :time_zone, :trip

  def minutes_since_trip_start
    (start_time_with_zone - Time.zone.parse(@trip.start_date.to_s)) / 60
  end

  def minutes_end_since_trip_start
    (start_time_with_zone - Time.zone.parse(@trip.start_date.to_s)) / 60 + duration
  end

  def start_time_str
    minutes_to_time(start_time)
  end

  def end_time_str
    minutes_to_time(end_time)
  end

  def start_time_with_zone
    @start_time_with_zone ||= Time.use_zone(@time_zone) do
      Time.zone.local(@date.year, @date.month, @date.day, start_absolute_hours, start_absolute_minutes)
    end
  end

  protected

  def color
    raise "Abstract method color called!"
  end

  def duration
    raise "Abstract method duration called!"
  end

  def tool_tip_message
    raise "Abstract method tool_tip_message called!"
  end

  def minutes_to_time(time_in_minutes)
    Time.at(time_in_minutes * 60).gmtime.strftime('%I:%M%p')
  end

  def start_absolute_hours
    @start_time / 60
  end

  def start_absolute_minutes
    @start_time % 60
  end

end