# -*- coding: utf-8 -*-
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
lga = Airport.create(:airport_code => "LGA", :full_name => "La Guardia, NY", :time_zone_id => est.id)

Carrier.destroy_all
virgin = Carrier.create(:name => 'Virgin America')
southwest = Carrier.create(:name => 'Southwest Airlines')
united = Carrier.create(:name => 'United Airlines')
delta = Carrier.create(:name => 'Delta Airlines')
us_airways = Carrier.create(:name => 'US Airways')

CarrierFlight.destroy_all
cf1 = CarrierFlight.create(:carrier_id => virgin.id, :number => "12", :from_id => sfo.id, :to_id => jfk.id, :start_time => 455, :end_time => 960)
cf2 = CarrierFlight.create(:carrier_id => virgin.id, :number => "29", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1150, :end_time => 1365)
cf3 = CarrierFlight.create(:carrier_id => southwest.id, :number => "2103", :from_id => lax.id, :to_id => sfo.id, :start_time => 365, :end_time => 445)
cf4 = CarrierFlight.create(:carrier_id => southwest.id, :number => "1321", :from_id => sfo.id, :to_id => lax.id, :start_time => 685, :end_time => 765)
cf5 = CarrierFlight.create(:carrier_id => united.id, :number => "0064", :from_id => sfo.id, :to_id => sea.id, :start_time => 380, :end_time => 509)
cf7 = CarrierFlight.create(:carrier_id => virgin.id, :number => "13", :from_id => sfo.id, :to_id => jfk.id, :start_time => 560, :end_time => 1000)
cf8 = CarrierFlight.create(:carrier_id => virgin.id, :number => "28", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1125, :end_time => 1350)
cf7 = CarrierFlight.create(:carrier_id => virgin.id, :number => "13", :from_id => sfo.id, :to_id => jfk.id, :start_time => 560, :end_time => 1000)

#demo seeds
cf9 = CarrierFlight.create(:carrier_id => delta.id, :number => "2040", :from_id => sfo.id, :to_id => jfk.id, :start_time => 930, :end_time => 1439)
cf10 = CarrierFlight.create(:carrier_id => delta.id, :number => "2865", :from_id => jfk.id, :to_id => sfo.id, :start_time => 435, :end_time => 640)
cf13 = CarrierFlight.create(:carrier_id => southwest.id, :number => "2113", :from_id => sfo.id, :to_id => jfk.id, :start_time => 660, :end_time => 1169)
cf14 = CarrierFlight.create(:carrier_id => southwest.id, :number => "1421", :from_id => jfk.id, :to_id => sfo.id, :start_time => 685, :end_time => 905)

cf15 = CarrierFlight.create(:carrier_id => united.id, :number => "0014", :from_id => sfo.id, :to_id => jfk.id, :start_time => 963, :end_time => 32)
cf16 = CarrierFlight.create(:carrier_id => united.id, :number => "0863", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1045, :end_time => 1270)

cf17 = CarrierFlight.create(:carrier_id => us_airways.id, :number => "1496", :from_id => sfo.id, :to_id => jfk.id, :start_time => 505, :end_time => 1007)
cf18 = CarrierFlight.create(:carrier_id => us_airways.id, :number => "469", :from_id => jfk.id, :to_id => sfo.id, :start_time => 955, :end_time => 1262)

cf19 = CarrierFlight.create(:carrier_id => virgin.id, :number => "12", :from_id => sfo.id, :to_id => jfk.id, :start_time => 455, :end_time => 960)
cf20 = CarrierFlight.create(:carrier_id => virgin.id, :number => "129", :from_id => jfk.id, :to_id => sfo.id, :start_time => 1150, :end_time => 1365)


User.destroy_all
tony = User.create(:first_name => "Tony", :last_name => "Newb", :email => "tonylc@gmail.com", :photo_url => "tony.png")
mabel = User.create(:first_name => "Mabel", :last_name => "Yoshimoto", :email => "myoshimoto@gmail.com", :photo_url => "mabel.png")
lijen = User.create(:first_name => "Lijen", :last_name => "Tan", :email => "lijentan@gmail.com", :photo_url => "lijen.png")

Trip.destroy_all
new_york_trip = Trip.create(:name => "New York Trip", :start_date => Date.new(2011,5,6), :end_date => Date.new(2011,5,8))

TripUser.destroy_all
tony.trips << new_york_trip
tony.save!

mabel.trips << new_york_trip
mabel.save!

lijen.trips << new_york_trip
lijen.save!

Flight.destroy_all
Flight.create(:user_id => tony.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf1.id, :seat_number => "16E", :start_date => Date.new(2011, 5, 6), :end_date => Date.new(2011, 5, 6), :confirmation_number => "ASDF1234")
Flight.create(:user_id => lijen.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf9.id, :seat_number => "16E", :start_date => Date.new(2011, 5, 6), :end_date => Date.new(2011, 5, 6), :confirmation_number => "ASDF2345")
Flight.create(:user_id => tony.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf2.id, :seat_number => "13E", :start_date => Date.new(2011, 5, 8), :end_date => Date.new(2011, 5, 8), :confirmation_number => "ASDF1234")
Flight.create(:user_id => mabel.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf7.id, :seat_number => "16F", :start_date => Date.new(2011, 5, 6), :end_date => Date.new(2011, 5, 6), :confirmation_number => "ASDF6352")
Flight.create(:user_id => mabel.id, :trip_id => new_york_trip.id, :carrier_flight_id => cf8.id, :seat_number => "13F", :start_date => Date.new(2011, 5, 8), :end_date => Date.new(2011, 5, 8), :confirmation_number => "ASDF6352")

Restaurant.destroy_all
momo = Restaurant.create(:name => "Momofuku Ssäm Bar", :address => "207 2nd Ave", :city => "New York", :state => "NY", :zip => "10003", :phone => "2122543500", :url => "http://www.momofuku.com/ssam/default.asp", :map_url => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=207+Second+Ave,+New+York,+NY&aq=0&sll=37.774593,-122.441097&sspn=0.009718,0.013561&ie=UTF8&hq=&hnear=207+2nd+Ave,+New+York,+10003&z=16&iwloc=A", :yelp_url => "http://www.yelp.com/biz/momofuku-ssam-bar-new-york")
lam_zhou = Restaurant.create(:name => "Lam Zhou Handmade Noodle", :address => "144 E Broadway", :city => "New York", :state => "NY", :zip => "10002", :phone => "2125666933", :map_url => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=144+E+Broadway,+New+York,+NY&aq=&sll=40.73169,-73.985846&sspn=0.009317,0.013561&ie=UTF8&hq=&hnear=144+E+Broadway,+New+York,+10002&z=16&iwloc=A", :yelp_url => "http://www.yelp.com/biz/lam-zhou-handmade-noodle-new-york")
ippudo = Restaurant.create(:name => "Ippudo NY", :address => "65 4th Ave", :city => "New York", :state => "NY", :zip => "10003", :phone => "2123880088", :url => "http://www.ippudo.com/ny", :map_url => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=ippudo+ny,+65+4th+Ave,+new+york,+ny&aq=&sll=40.730739,-73.990281&sspn=0.009317,0.013561&g=65+4th+Ave,+new+york,+ny&ie=UTF8&hq=Ippudo+Ny&hnear=Ippudo+Ny,+65+4th+Ave,+New+York,+10003&ll=40.731779,-73.990259&spn=0.035642,0.054245&z=14", :yelp_url => "http://www.yelp.com/biz/ippudo-ny-new-york")

Meal.destroy_all
Meal.create(:trip_id => new_york_trip.id, :user_id => tony.id, :restaurant_id => momo.id, :date => Date.new(2011,5,6), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => tony.id, :restaurant_id => lam_zhou.id, :date => Date.new(2011,5,7), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => tony.id, :restaurant_id => ippudo.id, :date => Date.new(2011,5,8), :start_time => 720)
Meal.create(:trip_id => new_york_trip.id, :user_id => mabel.id, :restaurant_id => momo.id, :date => Date.new(2011,5,6), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => mabel.id, :restaurant_id => lam_zhou.id, :date => Date.new(2011,5,7), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => mabel.id, :restaurant_id => ippudo.id, :date => Date.new(2011,5,8), :start_time => 720)
Meal.create(:trip_id => new_york_trip.id, :user_id => lijen.id, :restaurant_id => momo.id, :date => Date.new(2011,5,6), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => lijen.id, :restaurant_id => lam_zhou.id, :date => Date.new(2011,5,7), :start_time => 1080)
Meal.create(:trip_id => new_york_trip.id, :user_id => lijen.id, :restaurant_id => ippudo.id, :date => Date.new(2011,5,8), :start_time => 720)

Hotel.destroy_all
waldorf = Hotel.create(:name => "Waldorf Astoria", :address => "301 Park Avenue", :city => "New York", :state => "NY", :zip => "10022", :phone => "2123553000", :url => "http://waldorfnewyork.com", :map_url => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=301+Park+Avenue,+New+York,+NY+10022&aq=&sll=40.756782,-73.973866&sspn=0.008338,0.0159&ie=UTF8&hq=&hnear=301+Park+Ave,+New+York,+10022&ll=40.756539,-73.974059&spn=0.008745,0.0159&z=16")
w_hotel = Hotel.create(:name => "The W New York Hotel", :address => "201 Park Avenue South", :city => "New York", :state => "NY", :zip => "10003", :phone => "2122539119", :url => "http://starwoodhotels.com", :map_url => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=201+Park+Avenue+South,+New+York,+NY+10003&aq=&gl=us&ie=UTF8&hq=&hnear=201+Park+Ave+S,+New+York,+10003&z=16")

Lodging.destroy_all
l1 = Lodging.create(:trip_id => new_york_trip.id, :hotel_id => waldorf.id, :check_in_date => Date.new(2011,5,6), :check_out_date => Date.new(2011,5,7), :check_in_time => 1020, :check_out_time => 840)
l2 = Lodging.create(:trip_id => new_york_trip.id, :hotel_id => w_hotel.id, :check_in_date => Date.new(2011,5,7), :check_out_date => Date.new(2011,5,8), :check_in_time => 1020, :check_out_time => 840)

UserLodging.destroy_all
UserLodging.create(:lodging_id => l1.id, :user_id => tony.id)
UserLodging.create(:lodging_id => l1.id, :user_id => mabel.id)
UserLodging.create(:lodging_id => l2.id, :user_id => tony.id)
UserLodging.create(:lodging_id => l2.id, :user_id => mabel.id)
