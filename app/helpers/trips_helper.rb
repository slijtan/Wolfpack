module TripsHelper
  TRIP_SEGMENT_BLOCK = 1
  NUM_HOURS_IN_SEGMENT = 8

  def num_trip_time_blocks(trip)
    trip.duration_in_hours / NUM_HOURS_IN_SEGMENT
  end

  def convert_index_to_time(trip, airport, index)
    time_segment = Time.use_zone(airport.time_zone.name) do
      (trip.start_date_with_zone + (index * NUM_HOURS_IN_SEGMENT).hours).strftime("%I%p")
    end
    time_segment.starts_with?("0") ? "<span style=\"visibility:hidden;\">0</span>".html_safe + time_segment[1..-1] : time_segment
  end

  def minutes_to_time(time_in_minutes)
    Time.at(time_in_minutes * 60).gmtime.strftime('%I:%M%p')
  end

  def date_str(date)
    date.strftime("%a %m/%d")
  end

  def user_photo(user)
    image_tag (user.photo_url.blank? ? "no_user.jpg" : user.photo_url), :title => user.full_name, :class => "user-photo"
  end

  def event_class(event)
    case event.class.to_s
    when "FlightEvent"
      return "event-flight"
    when "LodgingEvent"
      return "event-lodging"
    when "MealEvent"
      return "event-meal"
    end
  end
end
