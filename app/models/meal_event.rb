# flights that have the same carrier flights and dates
class MealEvent < TripEvent
  attr_reader :restaurant
  COLOR = "#D0F5A9"

  def initialize(meals)
    raise "Invalid Meal Event with meals ids: #{meals.collect(&:id).join(",")}" unless validate_entities(meals, :restaurant_id)

    first_meal = meals.first
    @trip = first_meal.trip
    @restaurant = first_meal.restaurant
    @start_date = first_meal.date
    @start_time = first_meal.start_time
    @end_time = @start_time + 90
    @users = meals.collect(&:user)
    @time_zone = TimeZone.last.name
  end

  def icon_class
    "m"
  end

  def color
    COLOR
  end

  def tool_tip_partial
    "trips/meal_info"
  end

  def locals_hash
    { :restaurant => @restaurant,
      :start_time => @start_time,
      :users => @users }
  end

  def duration
    120
  end
end
