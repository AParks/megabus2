class Route
  def initialize(points)
    @points = points
  end
  
  def reverse
    @points.reverse
  end
  
  def self.multipoint_routes
    { 
      ["Pittsburgh, PA", "Baltimore, MD"]   => ["Pittsburgh, PA", "Philadelphia, PA", "Baltimore, MD"],
      ["Philadelphia,PA", "Albany,NY"] => ["Philadelphia, PA", "New York, NY", "Albany, NY"],
	  ["Boston, MA", "Albany, NY"] => ["Boston, MA", "New York, NY", "Albany, NY"],
	  ["Pittsburgh, PA", "Albany, NY"] => ["Pittsburgh, PA", "New York", "Albany, NY"],
	  ["Baltimore, MD", "Albany, NY"] => ["Baltimore, MA", "New York, NY", "Albany,NY"]
	  
    }
  end
  
end