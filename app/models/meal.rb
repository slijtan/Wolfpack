class Meal < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :trip
  belongs_to :user
end
