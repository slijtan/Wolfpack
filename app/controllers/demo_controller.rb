class DemoController < ApplicationController

  def index
    @carriers = Carrier.order("name")
  end

  def create_flight
    carrier_short_name = params[:carrier]
    full_name = params[:name]
    trip = Trip.first

    redirect_to root_path, :error => "Invalid receipt" if carrier_short_name.blank? || full_name.blank?

    carrier = Carrier.find_by_short_name(carrier_short_name)

    email = full_name.downcase.gsub(/ /, ".")
    first_name, last_name = *full_name.split(" ", 2)
    
    user = User.create(:first_name => first_name, :last_name => last_name, :email => "#{email}@gmail.com")
    
    dep_flight, dep_start_date, dep_end_date = departing_carrier_flight(carrier)
    ret_flight, ret_start_date, ret_end_date = returning_carrier_flight(carrier)

    dep_flight.create_flight(user, trip, dep_start_date, dep_end_date)
    ret_flight.create_flight(user, trip, ret_start_date, ret_end_date)
    
    redirect_to trip_path(:id => trip, :new_id => user.id), :notice => "Fights successfully added"
  end

  private

  def departing_carrier_flight(carrier)
    
    case carrier.name
    when "Delta Airlines"
      number = "2040"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-06')
      
    when "Virgin America"
      number = "12"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-06')

    when "Southwest Airlines"
      number = "2113"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-06')
      
    when "United Airlines"
      number = "0014"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-07')

    when "US Airways"
      number = "1496"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-06')

    when "Jetblue"
      number = "648"
      departing_start_date = Date.parse('2011-05-06')
      departing_end_date = Date.parse('2011-05-06')

    end
    
    return CarrierFlight.where(["number = ? AND carrier_id = ?", number, carrier]).first, departing_start_date, departing_end_date
  end

  def returning_carrier_flight(carrier)
    
    case carrier.name
    when "Delta Airlines"
      number = "2040"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    when "Virgin America"
      number = "129"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    when "Southwest Airlines"
      number = "1421"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    when "United Airlines"
      number = "0863"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    when "US Airways"
      number = "1496"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    when "Jetblue"
      number = "641"
      returning_start_date = Date.parse('2011-05-08')
      returning_end_date = Date.parse('2011-05-08')

    end

    return CarrierFlight.where(["number = ? AND carrier_id = ?", number, carrier]).first, returning_start_date, returning_end_date
  end

end
