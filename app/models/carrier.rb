class Carrier < ActiveRecord::Base
  has_many :carrier_flights

  def short_name
    name.gsub(/ /, "_").downcase
  end
end
