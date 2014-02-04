class LocationsController < ApplicationController
  def index
    @locations = Location.all
    gon.locations = @locations
    render :index
  end
end
