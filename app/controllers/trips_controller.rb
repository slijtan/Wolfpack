class TripsController < ApplicationController  
  def show
    @trip = Trip.includes(:users => :flights).find(params[:id])
    @destinations = [@trip.flights.first]
  end
end
