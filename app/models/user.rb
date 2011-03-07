class User < ActiveRecord::Base
  has_many :trips, :through => :trip_users
  has_many :trip_users, :dependent => :destroy
  has_many :flights

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
