class BusesController < ApplicationController

before_filter do
        @cities = City.order('name');
  end
  # GET /buses
  # GET /buses.json
  def index
    @buses = Bus.order('leaving_from_id')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buses }
    end
  end
  


end
