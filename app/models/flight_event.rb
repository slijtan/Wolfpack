# flights that have the same carrier flights and dates
class FlightEvent < TripEvent
  attr_reader :carrier_flight

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
    "#900000"
  end

  def border_color
    "#730000"
  end

  def tool_tip_message
    tool_tip = "
    <div class=\"tool-tip flight\">
      <ul>
        <li>#{@carrier_flight.flight_title}
        <li>From: #{@start_date.strftime("%a %m/%d")} #{start_time_str} #{@carrier_flight.from.airport_code}
        <li>To: #{@end_date.strftime("%a %m/%d")} #{end_time_str} #{@carrier_flight.to.airport_code}
        <li>
      </ul>
      <h6>Passengers:</h6>
      <div class=\"confirmed-participants\">"
    @users.each do |user|
      tool_tip << "<img class=\"user-photo\" title=\"#{user.full_name}\" src=\"/images/#{(user.photo)}\"/>"
    end
    tool_tip << "
      </div>
    </div>"
    tool_tip.html_safe
  end

  def duration
    @carrier_flight.flight_duration
  end
end