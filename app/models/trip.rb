class Trip < ActiveRecord::Base
  has_many :users, :through => :trip_users
  has_many :trip_users, :dependent => :destroy
  has_many :flights

  def duration_in_days
    duration_in_hours / 24
  end

  def duration_in_hours
    (end_date - start_date + 1.day) / 3600
  end

  def start_date_with_zone
    Time.zone.parse(self.start_date.to_s)
  end

  # this is wrong..need to sort!
  def start_time_zone
    self.flights.first.from.time_zone.name
  end
end
