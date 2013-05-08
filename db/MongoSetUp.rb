class MongoSetUp

  def initialize start_city, end_city 
    @start_city = start_city
    @end_city = end_city
    @routes = Array.new
    @max_layover = 0
    @total_layover = 0
  end


  def getAllRoutes
    (1..4).each do |i|
      sql_journey_results = journeysOfLength i
      getBusesFromJourneysOfLength i, sql_journey_results
    end
    @routes 
  end


  def selectStatement i
    select = " b#{i}.id AS b#{i}id, " + 
            "b#{i}.leaving_from_id AS b#{i}leaving_from, " + 
            "b#{i}.traveling_to_id AS b#{i}traveling_to " 
  end

#find journeys of length i
  def journeysOfLength count
    select = "select " + selectStatement(1)
    from = " from buses b#{1} "
    where = " where b1.leaving_from_id='#{@start_city}' "
    i = 1
    while i < count do
      select = select + "," + selectStatement(i + 1)
      from = from + ", buses b#{i + 1} "

      # validTime was left out for practical purposes
      validTime = " AND b#{i}.arrival_time < b#{i + 1}.leave_time "
      incidentEdges = " AND b#{i}.traveling_to_id = b#{i + 1}.leaving_from_id "
      notSameEdge = "AND b#{i}.leaving_from_id <> b#{i + 1}.traveling_to_id "
      where = where + incidentEdges + notSameEdge + validTime
      i+= 1
    end
    where = where + " AND b#{i}.traveling_to_id='#{@end_city}'"
    sql = select.chomp(',') + from.chomp(',') + where.chomp('AND')

    ActiveRecord::Base.connection.execute sql 

  end


# from each tuple of the queried result, 
# extract the id columns to find 
#the corresponding Bus objects, and save them to an array 
  def getBusesFromJourneysOfLength count, sql_journey_results 
  
  puts sql_journey_results
  #each result has a journey with count bus legs, and thus count bus IDs
    sql_journey_results.each do |result| 
      route = Hash.new
      buses = Array.new
      busmong_array = Array.new
      route["info"] = Array.new
      route["price"] = 0

      #find the journeys of length i 
      count.times do |i|
        bus_prev = Bus.find_by_id result["b#{i}id"] 
        bus = Bus.find_by_id result["b#{i+1}id"]
        
        calculateLayover bus_prev, bus unless i<=0
        busmong = convertToBusMong(bus)
        route["price"] += busmong["price"]
        busmong_array.push  busmong#add previous array to array of all buses
      end

      route["max_layover"] = convertLayover @max_layover
      route["total_layover"] = convertLayover @total_layover
      route["info"].push *busmong_array #each journey has an array of buses
      @routes.push route

    end
  end

  def convertToBusMong bus
        busmong = bus.as_json  :except => [ :id, :leave_time, :arrival_time]

        busmong = cityInfo busmong, "leaving_from", bus.leaving_from
        busmong = cityInfo busmong, "traveling_to", bus.traveling_to
        busmong["leave_time"] = bus.leave_time.utc
        busmong["arrival_time"] = bus.arrival_time.utc
        busmong["price"] = busmong["price"].to_i

        busmong
  end



  def cityInfo busmong, city_type, city
    busmong[city_type + "_name"] = city.name
    busmong[city_type + "_id"] = city.megabusID
    busmong[city_type + "_time_zone"] = city.timezone
    busmong
  end



  def convertLayover layover
    
    hours = layover/3600
    
    remaining_secs = layover % 3600
    minutes = remaining_secs/60
    hours.to_s + "h " + minutes.to_s + "min"
  end

  def calculateLayover bus_prev, bus
      puts bus_prev.arrival_time
      puts bus.leave_time
      a_secs = bus_prev.arrival_time.to_f
      l_secs = bus.leave_time.to_f
      layover = l_secs - a_secs

      puts "layover"
      puts (layover/3600).to_s + "h"
      puts (layover % 3600)/60

      if layover > @max_layover then
        @max_layover = layover
      end
      @total_layover += layover 

  end


end
