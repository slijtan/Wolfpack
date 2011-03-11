class LodgingEvent < TripEvent
  attr_reader :hotel

  def initialize(lodgings, date, start_time)
    raise "Invalid Lodging Event with lodging ids: #{lodgings.collect(&:id).join(",")}" unless validate_entities(lodgings, :hotel_id, :check_in_date)

    lodging = lodgings.first
    @trip = lodging.trip
    @hotel = lodging.hotel
    @date = date
    @start_time = start_time
    @end_time = @start_time + 30
    @users = lodging.user_lodgings.collect(&:user)
    @time_zone = TimeZone.first.name
  end

  def color
    "blue"
  end

  def tool_tip_message
    "Sleepers: #{@users.map(&:full_name).join(",")}"
  end

  def duration
    30
  end
end
