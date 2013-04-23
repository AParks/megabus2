class CitiesController < ApplicationController
  # GET /cities
  # GET /cities.json
  def index
    @cities = City.order('name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end



end
