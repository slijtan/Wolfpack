class Trip < ActiveRecord::Base
  has_many :users, :through => :trip_users
  has_many :trip_users, :dependent => :destroy
  has_many :flights
  has_many :meals
  has_many :lodgings

  def duration_in_days
    duration_in_hours / 24
  end

  def duration_in_hours
    duration_in_minutes / 60
  end

  def duration_in_minutes
    (end_date - start_date + 1.day) / 60
  end

  def start_date_with_zone
    Time.zone.parse(self.start_date.to_s)
  end

  def event_blocks
    event_array = []
    block = []
    events.each do |event|
      fit_in_block = false
      event_array.each_with_index do |block, index|
        if event.minutes_since_trip_start > block.last.minutes_end_since_trip_start
          block << event
          fit_in_block = true
          break
        end
      end
      unless fit_in_block
        # create new block
        event_array << [event]
      end
    end
    event_array
  end

  # this is wrong..need to sort!
  def start_time_zone
    self.flights.first.from.time_zone.name
  end

  private

  def events
    @events ||= begin
      events = get_flight_events
      events << get_meal_events
      events.flatten
    end.sort_by(&:start_time_with_zone)
  end

  def get_flight_events
    flights_hash = {}

    flights.each do |flight|
      generated_key = flight.date_carrier_flight_id
      unless flights_hash[generated_key]
        flights_hash[generated_key] = []
      end
      flights_hash[generated_key] << flight
    end

    flight_events = []
    flights_hash.each_value do |flights|
      flight_events << FlightEvent.new(flights)
    end
    flight_events
  end

  def get_meal_events
    meals_hash = {}

    meals.each do |meal|
      generated_key = meal.date_restaurant_id
      unless meals_hash[generated_key]
        meals_hash[generated_key] = []
      end
      meals_hash[generated_key] << meal
    end

    meal_events = []
    meals_hash.each_value do |meals|
      meal_events << MealEvent.new(meals)
    end
    meal_events
  end
end
