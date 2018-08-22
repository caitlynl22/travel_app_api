class LocationsController < ApplicationController
  before_action :set_trip
  before_action :set_trip_location, only: [:show, :update, :destroy]

  # GET /trips/:trip_id/locations
  def index
    json_response(@trip.locations)
  end

  # GET /trips/:trip_id/locations/:id
  def show
    json_response(@location)
  end

  # POST /trips/:trip_id/locations
  def create
    @location = @trip.locations.create!(location_params)
    json_response(@location, :created)
  end

  # PATCH /trips/:trip_id/locations/:id
  def update
    @location.update(location_params)
    head :no_content
  end

  # DELETE /trips/:trip_id/locations/:id
  def destroy
    @location.destroy
    head :no_content
  end

  private

  def location_params
    params.permit(:country, :city, :region, :latitude, :longitude)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_trip_location
    @location = @trip.locations.find_by!(id: params[:id]) if @trip
  end
end
