# flights that have the same carrier flights and dates
class FlightEvent < TripEvent
  attr_reader :carrier_flight

  def initialize(flights)
    raise "Invalid Flight Event with flight ids: #{flights.collect(&:id).join(",")}" unless validate_flights(flights)

    first_flight = flights.first
    @trip = first_flight.trip
    @carrier_flight = first_flight.carrier_flight
    @date = first_flight.date
    @start_time = @carrier_flight.start_time
    @end_time = @carrier_flight.end_time
    @users = flights.collect(&:user)
    @time_zone = first_flight.from.time_zone.name
  end

  def color
    "red"
  end

  def tool_tip_message
    "Passengers on this flight: #{@users.map(&:full_name).join(",")}"
  end

  def duration
    @carrier_flight.flight_duration
  end

  private

  def validate_flights(flights)
    # must all have the same carrier flight id and must be flying the same date
    date_array, carrier_flight_array, trip_array = [], [], []
    flights.each do |flight|
      date_array << flight.date
      carrier_flight_array << flight.carrier_flight_id
      trip_array << flight.trip_id
    end
    date_array.uniq.size == 1 && carrier_flight_array.uniq.size == 1 && trip_array.uniq.size == 1
  end
end