class Meal < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :trip
  belongs_to :user

  def date_restaurant_id
    "#{self.date.strftime("%Y_%m_%d")}_#{self.restaurant_id}"
  end
end
