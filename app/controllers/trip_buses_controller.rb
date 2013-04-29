class TripBusesController < ApplicationController



  def index
    @trip = Trip.find(params[:id])
    rowCount = (Bus.all).length
    trip = TripMongo.find_by_start_city_and_end_city(@trip[:leaving_from_id], @trip[:traveling_to_id])
   

	if (trip != nil) 
		@routes = trip.routes
	else
		@routes = Array.new
	end
 	
	
   
  #  @paginated_journeys =  @journeys.page(params[:page]).per(5)
  end


end
