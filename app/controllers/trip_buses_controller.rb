class TripBusesController < ApplicationController


def index

@buses = Bus.all

    render "buses/index"

end

end