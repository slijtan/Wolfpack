# flights that have the same carrier flights and dates
class FlightEvent < TripEvent
  attr_reader :carrier_flight

  def initialize(flights)
    raise "Invalid Flight Event with flight ids: #{flights.collect(&:id).join(",")}" unless validate_entities(flights, :carrier_flight_id)

    first_flight = flights.first
    @trip = first_flight.trip
    @carrier_flight = first_flight.carrier_flight
    @start_date = first_flight.date
    @start_time = @carrier_flight.start_time
    @end_time = @carrier_flight.end_time
    @users = flights.collect(&:user)
    @time_zone = first_flight.from.time_zone.name
  end

  def color
    "#900000"
  end

  def border_color
    "#730000"
  end

  def tool_tip_message
    "Passengers on this flight: #{@users.map(&:full_name).join(",")}"
  end

  def duration
    @carrier_flight.flight_duration
  end
end