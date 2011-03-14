class TripEvent
  attr_reader :start_time, :end_time, :start_date, :end_date, :users, :time_zone, :trip

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
      Time.zone.local(@start_date.year, @start_date.month, @start_date.day, start_absolute_hours, start_absolute_minutes)
    end
  end

  def end_time_with_zone
    @end_time_with_zone ||= Time.use_zone(@time_zone) do
      Time.zone.local(@end_date.year, @end_date.month, @end_date.day, end_absolute_hours, end_absolute_minutes)
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

  def validate_entities(entities, entity_id_method, date_method=:date)
    # must all be on the same date for the same trip
    date_array, entity_array, trip_array = [], [], []
    entities.each do |entity|
      date_array << entity.send(date_method)
      entity_array << entity.send(entity_id_method)
      trip_array << entity.trip_id
    end
    date_array.uniq.size == 1 && entity_array.uniq.size == 1 && trip_array.uniq.size == 1
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

  def end_absolute_hours
    @end_time / 60
  end

  def end_absolute_minutes
    @end_time % 60
  end

end