# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
require 'csv'
require_relative 'MongoSetUp'

cities_array = City.all
Bus.destroy_all

	if (cities_array.empty?) then
		cities_array = Array.new
		buses_array = Array.new
		CSV.foreach('cities.csv') do |row|
			if (row.length > 2) then
							puts row[0]
				city_hash = Hash.new
				city_hash[:id] = row[0]
				city_hash[:address] = row[0]
				city_hash[:name] = row[1]
				cities_array.push city_hash
			end
		end

		cities = City.create(cities_array)
	end
	if (Bus.all.empty?) then
		buses_array = Array.new
		
		CSV.foreach('cities.csv') 	do |row|
							
			leave = row[0]
			for i in 2..(row.length-1)
				puts "hi"
				puts row[0]
				bus_hash = Hash.new
				begin
					ltime = Time.utc(2013, 4, 30, rand(23), 0)	
					atime = Time.utc(2013, 4, 30, rand(23), 0)
				end until ltime < atime
				bus_hash[:leave_time] = ltime
				bus_hash[:arrival_time] = atime
				price = rand(25)
				arrive = row[i]
				bus_hash[:leaving_from] = City.find leave				
				bus_hash[:traveling_to] = City.find arrive
				bus_hash[:price] = price
				buses_array.push bus_hash
			end
		end
		#buses = BusMong.create(buses_array)
		buses = Bus.create(buses_array)
	end


	TripMongo.destroy_all
	cities = ActiveRecord::Base.connection.execute("Select * FROM cities ")
	cities.each do |start_city|
		cities.each do |end_city|
			if (end_city != start_city) then
				m = MongoSetUp.new(start_city["id"], end_city["id"])
 				(1..4).each do |i|
    				@sql_journey_results = m.journeysOfLength i
    				m.getBusesFromJourneysOfLength i, @sql_journey_results 
  				end
  				if (m.routes.any?) then
					TripMongo.create(:start_city => start_city["id"], :end_city =>end_city["id"], :routes => m.routes )
				end
			end
		end
	end


