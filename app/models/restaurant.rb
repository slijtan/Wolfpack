class Restaurant < ActiveRecord::Base
  include Addressable

  def yelp_rating_class
    @rating ||= begin
      "r#{self.yelp_rating % 10 == 0 ? self.yelp_rating / 10 : self.yelp_rating}"
    end
  end
end
