class MongoSetUp

  def initialize(start_city, end_city)
    @start_city = start_city
    @end_city = end_city
    @routes = Array.new
  end

  def routes
    @routes
  end


  def selectStatement (i)
    select = " b#{i}.id AS b#{i}id, " + 
            "b#{i}.leaving_from_id AS b#{i}leaving_from, " + 
            "b#{i}.traveling_to_id AS b#{i}traveling_to, " +
            "b#{i}.leave_time AS b#{i}leave_time, " +
            "b#{i}.arrival_time AS b#{i}arrival_time, " + 
            "b#{i}.price AS b#{i}price " 
  end


  def journeysOfLength count
    select = "select " + selectStatement(1)
    from = " from buses b#{1} "
    where = " where b1.leaving_from_id='#{@start_city}' "
    i = 1;
    while (i < count) do
      select = select + "," + selectStatement(i + 1)
      from = from + ", buses b#{i + 1} "
      notSameEdge = "AND b#{i}.leaving_from_id <> b#{i + 1}.traveling_to_id "
      validTime = "AND b#{i}.arrival_time < b#{i + 1}.leave_time"
      where = where + " AND b#{i}.traveling_to_id = b#{i + 1}.leaving_from_id " + notSameEdge + validTime
      i+= 1
    end

      
    where = where + " AND b#{i}.traveling_to_id='#{@end_city}'"
    sql = select.chomp(',') + from.chomp(',') + where.chomp('AND')
  
    #ActiveRecord::Base.connection.execute("DROP VIEW Journey")
    ActiveRecord::Base.connection.execute("CREATE VIEW Journey AS " + sql)
    sql_journey_results = ActiveRecord::Base.connection.execute("Select * FROM Journey ")
    ActiveRecord::Base.connection.execute("DROP VIEW Journey")

    return sql_journey_results
  end



  def getBusesFromJourneysOfLength count, sql_journey_results 
   

    sql_journey_results.each do |result| #each result has a journey with count bus legs
      route = Hash.new
      buses = Array.new
      busmong_array = Array.new
      route["info"] = Array.new
      route["price"] = 0

      (count).times do |i| 
        bus = Bus.find_by_id(result["b#{i+1}id"])
        busmong = bus.as_json

        busmong["price"] = busmong["price"].to_i
        route["price"] += busmong["price"]
        buses.push bus #array of buses
        busmong_array.push busmong #array of buses

      end

      route["info"].push *busmong_array #each journey has an array of buses
      @routes.push route

    end


  end


end
