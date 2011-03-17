class TripsController < ApplicationController  
  def show
    @trip = Trip.includes(:users => :flights).find(params[:id])
    @event_blocks = @trip.event_blocks
    @destinations = @trip.flights.map { |flight| flight.airports }.flatten.uniq
    @new_id = params[:new_id].to_i unless params[:new_id].blank?
  end
end
