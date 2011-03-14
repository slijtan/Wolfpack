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
end