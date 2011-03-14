class CarrierFlight < ActiveRecord::Base

  belongs_to :carrier
  belongs_to :from, :foreign_key => :from_id, :class_name => "Airport"
  belongs_to :to, :foreign_key => :to_id, :class_name => "Airport"

  def flight_title
    "#{carrier.name} Flight ##{number}"
  end

  # time is stored in minutes
  def flight_duration
    (end_time_in_zone - start_time_in_zone) / 60
  end

  private

  def end_time_in_zone
    Time.use_zone(self.to.time_zone.name) do
      Time.zone.parse(Date.new(2000,1,1).to_s) + end_time.minutes
    end
  end

  def start_time_in_zone
    Time.use_zone(self.from.time_zone.name) do
      Time.zone.parse(Date.new(2000,1,1).to_s) + start_time.minutes
    end
  end
end
