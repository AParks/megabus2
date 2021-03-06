# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
require 'csv'
require_relative 'MongoSetUp'


	def generateTimes j
		lday = 29
		ltime = DateTime.new(2013, 4, lday, j + rand(11), 0).utc
		ahour = rand(10) + 1 + ltime.hour 
		
		#puts "ahour before : #{ahour}"
		if ahour > 23 then
			ahour = ahour - 24 
			lday = 30
		end
		#puts "ahour after : #{ahour}"
		atime = DateTime.new(2013, 4, lday, ahour, 0).utc
		puts "to_i"
		puts atime.to_i
		puts ltime.to_i
		if atime.to_i < ltime.to_i then
			puts "ahour: #{ahour}"
			puts "lday: #{lday}"
			puts ltime
			puts atime
		end

		[ltime, atime]		
	end

	def loadCities
		if City.all.empty? then
			cities_array = Array.new
			buses_array = Array.new
			CSV.foreach 'cities.csv' do |row|
				city_hash = Hash.new
				city_hash[:megabusID] = row[0]
				city_hash[:id] = row[1]
				city_hash[:name] = row[2]
				city_hash[:timezone] = row[3]
				cities_array.push city_hash
			end
			cities = City.create! cities_array
		end
	end

	def loadBuses
		if City.all.any? && Bus.all.empty? then
		buses_array = Array.new
		
			CSV.foreach 'cities.csv' 	do |row|
				leave = row[1]
				for i in 4..(row.length-1)
					for j in [0, 12]
						bus_hash = Hash.new
						times = generateTimes j
						bus_hash[:leave_time] = times[0]
						bus_hash[:arrival_time] = times[1]
						price = 1 + rand(25)
						
						arrive = row[i]
						bus_hash[:leaving_from] = City.find leave				
						bus_hash[:traveling_to] = City.find arrive
						bus_hash[:price] = price
						buses_array.push bus_hash
					end
				end
			end
		buses = Bus.create! buses_array
		#buses = Bus.create buses_array
		
		end
	end
	

	def loadTripsIntoMongo
		TripMongo.destroy_all
		cities = City.all
		cities.each do |start_city|
			cities.each do |end_city|
				if (end_city != start_city) then
					s_id = start_city["megabusID"]
					e_id = end_city["megabusID"]
					m = MongoSetUp.new s_id , e_id
					
				 	routes = m.getAllRoutes
				  	if routes.any? then
				  		puts routes
						TripMongo.create :start_city => s_id, :end_city => e_id, :routes => routes
					end
				end
			end
		end
	end
#City.destroy_all
#loadCities
#Bus.destroy_all
#loadBuses
loadTripsIntoMongo
