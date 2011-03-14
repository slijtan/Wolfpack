class User < ActiveRecord::Base
  has_many :trips, :through => :trip_users
  has_many :trip_users, :dependent => :destroy
  has_many :flights

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def photo
    photo_url.blank? ? "no_user.jpg" : self.photo_url
  end
end
