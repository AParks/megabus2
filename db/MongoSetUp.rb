class MongoSetUp

  def initialize start_city, end_city 
    @start_city = start_city
    @end_city = end_city
    @routes = Array.new
    min_layover = 0
  end


  def getAllRoutes
    (1..3).each do |i|
      sql_journey_results = journeysOfLength i
      getBusesFromJourneysOfLength i, sql_journey_results
    end
    @routes 
  end


  def selectStatement i
    select = " b#{i}.id AS b#{i}id, " + 
            "b#{i}.leaving_from_id AS b#{i}leaving_from, " + 
            "b#{i}.traveling_to_id AS b#{i}traveling_to, " +
            "b#{i}.leave_time AS b#{i}leave_time, " +
            "b#{i}.arrival_time AS b#{i}arrival_time, " + 
            "b#{i}.price AS b#{i}price " 
  end

#find journeys of length i
  def journeysOfLength count
    select = "select " + selectStatement(1)
    from = " from buses b#{1} "
    where = " where b1.leaving_from_id='#{@start_city}' "
    i = 1
    while i < count do
      puts i
      select = select + "," + selectStatement(i + 1)
      from = from + ", buses b#{i + 1} "

      # validTime was left out for practical purposes
      #validTime = "AND b#{i}.arrival_time < b#{i + 1}.leave_time "
      incidentEdges = " AND b#{i}.traveling_to_id = b#{i + 1}.leaving_from_id "
      notSameEdge = "AND b#{i}.leaving_from_id <> b#{i + 1}.traveling_to_id "
      where = where + incidentEdges + notSameEdge
      i+= 1
    end
    where = where + " AND b#{i}.traveling_to_id='#{@end_city}'"
    sql = select.chomp ',' + from.chomp(',') + where.chomp('AND')
    puts sql

    ActiveRecord::Base.connection.execute sql 

  end


# from each tuple of the queried result, 
# extract the id columns to find 
#the corresponding Bus objects, and save them to an array 
  def getBusesFromJourneysOfLength count, sql_journey_results 
  
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
        calculateLayover bus_prev, bus
        busmong = bus.as_json

        busmong["leaving_from_name"] = bus.leaving_from.name
        busmong["traveling_to_name"] = bus.traveling_to.name
        busmong["price"] = busmong["price"].to_i
        route["price"] += busmong["price"]
        buses.push bus #array of buses
        busmong_array.push busmong #add previous array to array of all buses
      end

      route["min_layover"] = convertMinLayover
      route["info"].push *busmong_array #each journey has an array of buses
      @routes.push route

    end
  end

  def convertMinLayover
    hours = 0
    if min_layover >= 3600.0 then
      hours = min_layover/3600.0
    end
    remaining_secs = min_layover % 3600.0
    minutes = remaining_secs/60
    hours + "h " + minutes + "min"
  end

  def calculateLayover bus_prev, bus
      a_secs = bus_prev.traveling_to.arrival_time.to_f
      d_secs = bus.leaving_from.departure_time.to_f
      layover = d_secs - a_secs
      if layouver < min_layover then
        min_layover = layover
      end

  end


end
