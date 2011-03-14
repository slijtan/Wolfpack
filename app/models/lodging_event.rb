class LodgingEvent < TripEvent
  attr_reader :hotel

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
    "#000095"
  end

  def border_color
    "#000073"
  end

  def tool_tip_message
    tool_tip = "
    <div class=\"tool-tip lodging\">
      <ul>
        <li>#{@hotel.name}
        <li>#{@hotel.address}
        <li>#{@hotel.city_state_zip}
        <li>#{@hotel.formatted_phone}
        <li>Check In: #{start_date_str} #{start_time_str}
        <li>Check Out: #{end_date_str} #{end_time_str}
      </ul>
      <h6>Guests:</h6>
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
    (end_time_with_zone - start_time_with_zone) / 60
  end
end
