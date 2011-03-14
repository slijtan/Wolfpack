module Addressable
  def city_state_zip
    "#{self.city}, #{self.state} #{self.zip}"
  end
  
  def formatted_phone
    p = self.phone
    p.insert(3, ") ")
    p.insert(0, "(")
    p.insert(-5, " ")
  end
end