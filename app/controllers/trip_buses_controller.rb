class TripBusesController < ApplicationController
  def index

    @trip = Trip.find(params[:id])
    @route = @trip.route.points

    temp = []
    (0..@route.length-2).each do |x|
      leaving_from= Route.name_to_id[@route[x]]
      traveling_to= Route.name_to_id[@route[x + 1]]


      temp = temp + Bus.where("leaving_from_id =? AND traveling_to_id =?" , leaving_from, traveling_to)
    end

@buses = temp
    render "buses/index"

  end

end