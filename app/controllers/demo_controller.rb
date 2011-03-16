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

    departing_date = Date.parse('2011-05-06')
    returning_date = Date.parse('2011-05-08')
    email = full_name.downcase.gsub(/ /, ".")
    first_name, last_name = *full_name.split(" ", 2)
    
    user = User.create(:first_name => first_name, :last_name => last_name, :email => "#{email}@gmail.com")
    
    dep_flight = departing_carrier_flight(carrier)
    ret_flight = returning_carrier_flight(carrier)

    dep_flight.create_flight(user, trip, departing_date)
    ret_flight.create_flight(user, trip, returning_date)
    
    redirect_to trip_path(:id => trip), :notice => "Fights successfully added"
  end

  private

  def departing_carrier_flight(carrier)

    case carrier.name
    when "Delta Airlines" then number = "2040"
    when "Virgin America" then number = "12"
    when "Southwest Airlines" then number = "2103"
    when "United Airlines" then number = "0014"
    when "US Airways" then number = "1496"
    when "Jetblue" then number = "648"
    end
    
    return CarrierFlight.where(["number = ? AND carrier_id = ?", number, carrier]).first
  end

  def returning_carrier_flight(carrier)

    case carrier.name
    when "Delta Airlines" then number = "2040"
    when "Virgin America" then number = "29"
    when "Southwest Airlines" then number = "1321"
    when "United Airlines" then number = "0863"
    when "US Airways" then number = "0863"
    when "Jetblue" then number = "641"
    end

    return CarrierFlight.where(["number = ? AND carrier_id = ?", number, carrier]).first
  end

end
