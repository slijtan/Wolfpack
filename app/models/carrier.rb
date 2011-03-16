class Carrier < ActiveRecord::Base
  has_many :carrier_flights

  def self.find_by_short_name(short_name)
    Carrier.all.each do |carrier|
      return carrier if carrier.short_name == short_name
    end
  end

  def short_name
    name.gsub(/ /, "_").downcase
  end

end
