class LodgingEvent < TripEvent
  attr_reader :hotel
  COLOR = "#99CAFA"

  def initialize(lodgings)
    raise "Invalid Lodging Event with lodging ids: #{lodgings.collect(&:id).join(",")}" unless validate_entities(lodgings, :hotel_id, :check_in_date)

    lodging = lodgings.first
    @trip = lodging.trip
    @hotel = lodging.hotel
    @start_date = lodging.check_in_date
    @end_date = lodging.check_out_date
    @start_time = lodging.check_in_time
    @end_time = lodging.check_out_time
    @users = lodging.user_lodgings.collect(&:user)
    @time_zone = TimeZone.first.name
  end

  def color
    COLOR
  end

  def tool_tip_partial
    "trips/lodging_info"
  end

  def locals_hash
    { :hotel => @hotel,
      :start_date => @start_date,
      :end_date => @end_date,
      :start_time => @start_time,
      :end_time => @end_time,
      :users => @users }
  end

  def duration
    (end_time_with_zone - start_time_with_zone) / 60
  end
end
