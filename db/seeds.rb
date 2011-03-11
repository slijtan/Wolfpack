# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

TimeZone.destroy_all
pst = TimeZone.create(:name => 'Pacific Time (US & Canada)')
est = TimeZone.create(:name => 'Eastern Time (US & Canada)')

Airport.destroy_all
sfo = Airport.create(:airport_code => "SFO", :full_name => "San Francisco, CA", :time_zone_id => pst.id)
jfk = Airport.create(:airport_code => "JFK", :full_name => "New York, NY", :time_zone_id => est.id)
lax = Airport.create(:airport_code => "LAX", :full_name => "Los Angeles, CA", :time_zone_id => pst.id)
sea = Airport.create(:airport_code => "SEA", :full_name => "Seattle, WA", :time_zone_id => pst.id)
lgb = Airport.create(:airport_code => "LGB", :full_name => "Long Beach, CA", :time_zone_id => pst.id)

Carrier.destroy_all
virgin = Carrier.create(:name => 'Virgin America')
southwest = Carrier.create(:name => 'Southwest Airlines')
united = Carrier.create(:name => 'United Airlines')
jetblue = Carrier.create(:name => 'Jetblue')
delta = Carrier.create(:name => 'Delta Airlines')
us_airways = Carrier.create(:name => 'US Airways')
vueling = Carrier.create(:name => 'Vueling')

CarrierFlight.destroy_all
cf1 = CarrierFlight.create(:carrier_id => virgin.id, :number => "12", :from_id => sfo.id, :to_id => jfk.id, :start_time => 455, :end_time => 960)
cf2 = CarrierFlight.create(:carrier_id => virgin.id, :number => "29", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1150, :end_time => 1365)
cf3 = CarrierFlight.create(:carrier_id => southwest.id, :number => "2103", :from_id => lax.id, :to_id => sfo.id, :start_time => 365, :end_time => 445)
cf4 = CarrierFlight.create(:carrier_id => southwest.id, :number => "1321", :from_id => sfo.id, :to_id => lax.id, :start_time => 685, :end_time => 765)
cf5 = CarrierFlight.create(:carrier_id => united.id, :number => "0064", :from_id => sfo.id, :to_id => sea.id, :start_time => 380, :end_time => 509)
cf6 = CarrierFlight.create(:carrier_id => jetblue.id, :number => "1433", :from_id => sfo.id, :to_id => lgb.id, :start_time => 640, :end_time => 729)
cf7 = CarrierFlight.create(:carrier_id => virgin.id, :number => "13", :from_id => sfo.id, :to_id => jfk.id, :start_time => 560, :end_time => 1000)
cf8 = CarrierFlight.create(:carrier_id => virgin.id, :number => "28", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1125, :end_time => 1350)

User.destroy_all
tony = User.create(:first_name => "Tony", :last_name => "Newb", :email => "tonylc@gmail.com")
mabel = User.create(:first_name => "Mabel", :last_name => "Yoshimoto", :email => "myoshimoto@gmail.com")
lijen = User.create(:first_name => "Lijen", :last_name => "Tan", :email => "lijentan@gmail.com")

Trip.destroy_all
new_york_trip = Trip.create(:name => "New York Trip", :start_date => Date.new(2010, 12, 10), :end_date => Date.new(2010, 12 ,13))
los_angeles_trip = Trip.create(:name => "Los Angeles Trip", :start_date => Date.new(2011, 2, 7), :end_date => Date.new(2011, 2, 11))

TripUser.destroy_all
tony.trips << new_york_trip
tony.trips << los_angeles_trip
tony.save!

mabel.trips << new_york_trip
mabel.save!

lijen.trips << new_york_trip
lijen.save!

Flight.destroy_all
Flight.create(:user_id => tony.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf1.id, :seat_number => "16E", :date => Date.new(2010, 12, 10))
Flight.create(:user_id => tony.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf2.id, :seat_number => "13E", :date => Date.new(2010, 12, 13))
Flight.create(:user_id => mabel.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf7.id, :seat_number => "16F", :date => Date.new(2010, 12, 10))
Flight.create(:user_id => mabel.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf8.id, :seat_number => "13F", :date => Date.new(2010, 12, 13))
