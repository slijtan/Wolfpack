class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :carrier_flight

  delegate :flight_duration, :start_time, :end_time, :from, :to, :to => :carrier_flight

  #TODO: We need to first automatically determine the carrier from the email contents
  def self.import_delta_email(raw_html)
    flight_info = Hash.new
    valid_dates = %{Mon Tue Wed Thu Fri Sat Sun}

    doc = Nokogiri::HTML::Document.parse(raw_html)
    content_blocks = doc.css('pre')
    flight_block = content_blocks[1].content
    fair_block = content_blocks[3].content
    
    #CONFIRMATION NUMBER
    regex = Regexp.new(/DELTA CONFIRMATION #:\s+([\w\d]+)/)
    matches = regex.match(flight_block)
    
    flight_info[:confirmation_number] =  matches[1].strip
    
    #FLIGHTS
    p y flight_info
  end

  #TODO: user and trip are hard coded
  def self.import_united_email(raw_html)
    carrier = Carrier.find_by_name("United Airlines")
    user = User.first
    trip = Trip.first
    
    doc = Nokogiri::HTML::Document.parse(raw_html)
    
    #CONFIRMATION NUMBER
    confirmation_block = doc.css('.prd-fxd-div')[1].content
    regex = Regexp.new(/Confirmation #\s+([\w\d]+)/)
    matches = regex.match(confirmation_block)
    confirmation_number =  matches[1].strip
    
    #FLIGHTS
    flights_block = doc.css('table#flightTable tr')
    flights_block = flights_block.slice(2, flights_block.length - 3)
    
    new_flights = Array.new
    
    flights_block.each do |flight_block|
      new_flight = Flight.new(:user => user, :trip => trip, :confirmation_number => confirmation_number)

      regex = Regexp.new(/United (\d+).*((Mon|Tue|Wed|Thu|Fri|Sat|Sun),.*?(\w{3})\s(\d+),\s(\d{4})).*?((\d)+\w)/m)
      matches = regex.match(flight_block)
      
      new_flight.carrier_flight =  carrier.carrier_flights.find_by_number(matches[1].strip)
      new_flight.date = Date.parse(matches[2].strip)
      new_flight.seat_number = matches[7].strip

      new_flight.save!

      new_flights << new_flight
    end
    
    new_flights
  end

  def minutes_since_trip_start
    (start_time_with_zone - Time.zone.parse(trip.start_date.to_s)) / 60
  end

  def departure_time
    minutes_to_time(start_time)
  end

  def arrival_time
    minutes_to_time(end_time)
  end

  private
  
  def minutes_to_time(time_in_minutes)
    Time.at(time_in_minutes * 60).gmtime.strftime('%I:%M%p')
  end
  
  def start_time_with_zone
    @date_time ||= Time.use_zone(self.from.time_zone.name) do
      Time.zone.local(self.date.year, self.date.month, self.date.day, start_absolute_hours, start_absolute_minutes)
    end
  end

  def start_absolute_hours
    start_time / 60
  end

  def start_absolute_minutes
    start_time % 60
  end
end
