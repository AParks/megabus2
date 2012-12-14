class TripBusesController < ApplicationController
  def index

    @trip = Trip.find(params[:id])
    @route = @trip.route.points
    
    #print @route[0]
    #if @trip.leaving_from.name == @route[0]
    #@route.each do |x|

    #    unless @trip.leaving_from == x
    #     Bus.find_all_by_leaving_from x
    #    end
    #nd

#join_condition = " ,categories where INNER JOIN categories ON categories.id=videos.category"



    @buses = Bus.all(:joins => "JOIN trips ON buses.traveling_to_id = " + @trip.traveling_to_id.to_s +
    " OR buses.leaving_from_id = " + @trip.leaving_from_id.to_s,
    :select => 'DISTINCT buses.*',
    :order=> 'leave_time asc'   )

    render "buses/index"
    


  end

end