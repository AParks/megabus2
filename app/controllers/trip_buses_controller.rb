class TripBusesController < ApplicationController
  def index

    @trip = Trip.find(params[:id])
    rowCount = (Bus.all).length
    @journeys = Array.new
    (1..4).each do |i|
      sql_journey_results = journeysOfLength i , @trip[:leaving_from_id], @trip[:traveling_to_id]
      @journeys = getBusesFromJourneysOfLength i, sql_journey_results 
      #@journeys.push *journeys
    end

    render "index"
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
  
    ActiveRecord::Base.connection.execute("DROP VIEW Journey")
    ActiveRecord::Base.connection.execute("CREATE VIEW Journey AS " + sql)
    sql_journey_results = ActiveRecord::Base.connection.execute("Select * FROM Journey ")



  end


  def getBusesFromJourneysOfLength count, sql_journey_results 
    journeys = Array.new
    price = 0
      puts count

    sql_journey_results.each do |journey|
      buses= Array.new
      puts "new journey" 
      (count).times do |i| 
              puts i
        puts journey["b#{i+1}id"]
        bus = Bus.find_by_id(journey["b#{i+1}id"])
        buses.push bus #array of buses
      end

      journeys.push buses #array of buses arrays
    end



#    @buses.each { |bus|  price += bus.price }
    return journeys
  end


end
