# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
   cities = City.create([
        { name: 'Philadelphia, PA' , address: '30th St Station' },
        { name: 'Baltimore, MD' , address: 'White Marsh Park & Ride' },
        { name: 'Boston, MA', address: 'South Station' },   
        { name: 'New York, NY', address: '7th Ave & 28th St'},
        { name: 'Pittsburgh, PA',  address: '10th St and Penn Ave'},
        { name: 'Cleveland, OH', address: 'W 3rd St between Frankfort Ave and W Superior Ave'},
        { name: 'Amherst, MA', address: 'Hampshire Mall b/t Cinemark and the Arizona Pizza Company'},
        { name: 'Albany, NY' , address: 'SUNY Albany - Collins Circle'}])
        
 # buses = Bus.create([
 #   { price: 13 , leave_time: '2000-01-01 02:40:00 UTC', arrival_time: '2000-01-01 04:40:00 UTC',
 #     leaving_from: 1 , traveling_to: 4}, 
 #   { price: 13 , leave_time: '2000-01-01 06:00:00 UTC', arrival_time: '2000-01-01 08:00:00 UTC', 
 #     leaving_from: 1 , traveling_to: 4},
 #   {price: 11, leave_time: '2000-01-01 21:40:00 UTC', arrival_time: '2000-01-01 23:40:00 UTC' ,
 #     leaving_from: 4 , traveling_to: 1}
 #     ])      
#   Mayor.create(name: 'Emanuel', city: cities.first)
