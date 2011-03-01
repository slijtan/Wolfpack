class CarrierFlight < ActiveRecord::Base

  belongs_to :carrier
  belongs_to :from, :foreign_key => :from_id, :class_name => "Airport"
  belongs_to :to, :foreign_key => :to_id, :class_name => "Airport"
  
end
