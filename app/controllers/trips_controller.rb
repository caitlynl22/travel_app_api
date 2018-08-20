class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index
    @trips = Trip.all
    json_response(@trips)
  end

  # GET /trips/:id
  def show
    json_response(@trip)
  end

  # POST /trips
  def create
    @trip = Trip.create!(trip_params)
    json_response(@trip, :created)
  end

  # PATCH /trips/:id
  def update
    @trip.update(trip_params)
  end

  # DELETE /trips/:id
  def destroy
    @trip.destroy
    head :no_content
  end

  private

  def trip_params
    params.permit(:title, :from, :to, :description)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
