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
    "green"
  end

  def tool_tip_message
    "Eaters: #{@users.map(&:full_name).join(",")}"
  end

  def duration
    90
  end
end
