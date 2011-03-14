# flights that have the same carrier flights and dates
class MealEvent < TripEvent
  attr_reader :restaurant

  def initialize(meals)
    raise "Invalid Meal Event with meals ids: #{meals.collect(&:id).join(",")}" unless validate_entities(meals, :restaurant_id)

    first_meal = meals.first
    @trip = first_meal.trip
    @restaurant = first_meal.restaurant
    @start_date = first_meal.date
    @start_time = first_meal.start_time
    @end_time = @start_time + 90
    @users = meals.collect(&:user)
    @time_zone = TimeZone.first.name
  end

  def color
    "#528B42"
  end

  def border_color
    "#0F8F46"
  end

  def tool_tip_message
    tool_tip = "
    <div class=\"tool-tip meal\">
      <ul>
        <li>#{@restaurant.name} @ #{start_time_str}
        <li>#{@restaurant.address}
        <li>#{@restaurant.city_state_zip}
        <li>#{@restaurant.formatted_phone}
      </ul>
      <h6>Diners:</h6>"
    @users.each do |user|
      tool_tip << "<img class=\"user-photo\" title=\"#{user.full_name}\" src=\"/images/#{(user.photo_url.nil? ? "no_user.jpg" : user.photo_url)}\"/>"
    end
    tool_tip << "</div>"
    tool_tip.html_safe
  end

  def duration
    90
  end
end
