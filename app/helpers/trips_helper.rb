module TripsHelper
  TRIP_SEGMENT_BLOCK = 1
  NUM_HOURS_IN_SEGMENT = 4
  
  def num_trip_segments(trip)
    trip.duration_in_hours / NUM_HOURS_IN_SEGMENT
  end
  
  def convert_index_to_time(trip, index)
    Time.use_zone(trip.start_time_zone) do
      (trip.start_date_with_zone + (index * NUM_HOURS_IN_SEGMENT).hours).strftime("%I:%M %p")
    end
  end
  
  def flight_segment_width(flight)
    flight.flight_duration / 60 / NUM_HOURS_IN_SEGMENT
  end
  
  def flight_segment_starting_grid(flight)
    flight.minutes_since_trip_start / 60 / NUM_HOURS_IN_SEGMENT
  end
end