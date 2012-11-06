# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
   cities = City.create([
   { name: 'Albany, NY' , address: 'SUNY Albany - Collins Circle'},
   { name: 'Philadelphia, PA' , address: '30th St Station' },
   { name: 'Pittsburgh, PA',  },
   { name: 'New York, NY', address: '7th Ave & 28th St'},
   { name: 'Boston, MA', address: 'South Station' },   
   { name: 'Baltimore, MD' , address: 'White Marsh Park & Ride' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
