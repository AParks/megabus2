# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
require 'csv'

cities_array = Array.new
CSV.foreach('cities.csv') do |row|
	city_hash = Hash.new
	city_hash[:name] = row[1]
	city_hash[:address] = row[0]
	cities_array.push city_hash
end

 cities = City.create(cities_array)

buses_array = Array.new
500.times do
	bus_hash = Hash.new
	bus_hash[:price] = rand(25)
	bus_hash[:leave_time] = '2000-01-01 04:40:00 UTC'
	bus_hash[:arrival_time] = '2000-01-01 04:40:00 UTC'
	leave = cities_array[rand(cities_array.length)]
	arrive = cities_array[rand(cities_array.length)]
	bus_hash[:leaving_from] = City.find_by_name leave[:name]
	bus_hash[:traveling_to] = City.find_by_name arrive[:name]
	buses_array.push bus_hash


end
    
    buses = Bus.create(buses_array)
