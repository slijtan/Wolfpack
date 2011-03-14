class TripsController < ApplicationController  
  def show
    @trip = Trip.includes(:users => :flights).find(params[:id])
    @event_blocks = @trip.event_blocks
    @destinations = @trip.flights.map { |flight| flight.airports }.flatten.uniq
  end
end
