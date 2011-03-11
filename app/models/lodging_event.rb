class LodgingEvent < TripEvent
  attr_reader :hotel

  def initialize(lodgings, date, start_time)
    raise "Invalid Lodging Event with lodging ids: #{lodgings.collect(&:id).join(",")}" unless validate_lodging(lodgings)

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

  private

  def validate_lodging(lodgings)
    # must all have the same carrier flight id and must be flying the same date
    date_array, hotel_array, trip_array = [], [], []
    lodgings.each do |lodging|
      date_array << lodging.check_in_date
      hotel_array << lodging.hotel_id
      trip_array << lodging.trip_id
    end
    date_array.uniq.size == 1 && hotel_array.uniq.size == 1 && trip_array.uniq.size == 1
  end
end
