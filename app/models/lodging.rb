class Lodging < ActiveRecord::Base
  belongs_to :trip
  belongs_to :hotel
end
