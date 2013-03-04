class TripBusesController < ApplicationController
  def index
    @trip = Trip.find(params[:id])
    rowCount = (Bus.all).length
    @journeys = Array.new
    (1..2).each do |i|
      @sql_journey_results = journeysOfLength i , @trip[:leaving_from_id], @trip[:traveling_to_id]
      getBusesFromJourneysOfLength i, @sql_journey_results 
    end
   
  #  @paginated_journeys =  @journeys.page(params[:page]).per(5)
  end


  def selectStatement (i)
    select = " b#{i}.id AS b#{i}id, " + 
            "b#{i}.leaving_from_id AS b#{i}leaving_from, " + 
            "b#{i}.traveling_to_id AS b#{i}traveling_to, " +
            "b#{i}.leave_time AS b#{i}leave_time, " +
            "b#{i}.arrival_time AS b#{i}arrival_time, " + 
            "b#{i}.price AS b#{i}price " 
  end


  def journeysOfLength count , leaving_from_id, traveling_to_id 
    select = "select " + selectStatement(1)
    from = " from  buses b#{1} "
    where = " where b1.leaving_from_id='#{leaving_from_id}' "
    i = 1;
    while (i < count) do
      select = select + "," + selectStatement(i + 1)
      from = from + ", buses b#{i + 1} "
      where = where + " AND b#{i}.traveling_to_id = b#{i + 1}.leaving_from_id "
      i+= 1
    end

      
    where = where + " AND b#{i}.traveling_to_id='#{traveling_to_id}'"
    sql = select.chomp(',') + from.chomp(',') + where.chomp('AND')
  
    ActiveRecord::Base.connection.execute("CREATE VIEW Journey AS " + sql)
    sql_journey_results = ActiveRecord::Base.connection.execute("Select * FROM Journey ")
    ActiveRecord::Base.connection.execute("DROP VIEW Journey")

    return sql_journey_results
  end



  def getBusesFromJourneysOfLength count, sql_journey_results 
   

    sql_journey_results.each do |result| #each result has a journey with count bus legs
      buses= Array.new
      journey = Hash.new
      journey["info"] = Array.new
      journey["price"] = 0

      (count).times do |i| 
        bus = Bus.find_by_id(result["b#{i+1}id"])
        journey["price"] += bus.price
        buses.push bus #array of buses
      end

      journey["info"].push *buses #each journey has an array of buses
      @journeys.push journey
    end


  end


end
