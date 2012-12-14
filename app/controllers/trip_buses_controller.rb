class TripBusesController < ApplicationController
  def index

    @trip = Trip.find(params[:id])

    #@find(params[])

    @route = @trip.route.points
   
    @buses = []
    (0..@route.length).step(2).each do |x|

    leaving_from= Route.name_to_id[@route[x]]
    traveling_to = Route.name_to_id[@route[x + 1]]
      @buses = @buses + Bus.where("leaving_from_id =? AND traveling_to_id =?" , leaving_from, traveling_to)
    end


    render "buses/index"

  end

end