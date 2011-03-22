# flights that have the same carrier flights and dates
class FlightEvent < TripEvent
  attr_reader :carrier_flight
  COLOR = "#FAAFBE"

  def initialize(flights)
    raise "Invalid Flight Event with flight ids: #{flights.collect(&:id).join(",")}" unless validate_entities(flights, :carrier_flight_id, :start_date)

    first_flight = flights.first
    @trip = first_flight.trip
    @carrier_flight = first_flight.carrier_flight
    @start_date = first_flight.start_date
    @end_date = first_flight.end_date
    @start_time = @carrier_flight.start_time
    @end_time = @carrier_flight.end_time
    @users = flights.collect(&:user)
    @time_zone = first_flight.from.time_zone.name
  end

  def color
    COLOR
  end

  def tool_tip_partial
    "trips/flight_info"
  end

  def locals_hash
    { :carrier_flight => @carrier_flight,
      :start_date => @start_date,
      :end_date => @end_date,
      :start_time => @start_time,
      :end_time => @end_time,
      :users => @users }
  end

  def duration
    @carrier_flight.flight_duration
  end
end