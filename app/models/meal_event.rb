# flights that have the same carrier flights and dates
class MealEvent < TripEvent
  attr_reader :restaurant

  def initialize(meals)
    raise "Invalid Meal Event with meals ids: #{meals.collect(&:id).join(",")}" unless validate_meals(meals)

    first_meal = meals.first
    @trip = first_meal.trip
    @restaurant = first_meal.restaurant
    @date = first_meal.date
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

  private

  def validate_meals(meals)
    # must all have the same carrier flight id and must be flying the same date
    date_array, restaurant_array, trip_array = [], [], []
    meals.each do |meal|
      date_array << meal.date
      restaurant_array << meal.restaurant_id
      trip_array << meal.trip_id
    end
    date_array.uniq.size == 1 && restaurant_array.uniq.size == 1 && trip_array.uniq.size == 1
  end
end
