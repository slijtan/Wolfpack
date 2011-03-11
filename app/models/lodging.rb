class Lodging < ActiveRecord::Base
  belongs_to :trip
  belongs_to :hotel

  has_many :user_lodgings

  def check_in_hotel_id
    "#{self.check_in_date.strftime("%Y_%m_%d")}_#{self.check_in_time}_#{self.hotel_id}"
  end
end
