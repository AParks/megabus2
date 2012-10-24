class Route
  def initialize(points)
    @points = points
  end
  
  def reverse
    @points.reverse
  end
  
  def self.multipoint_routes
    { 
      ["Pittsburgh", "Baltimore"]   => ["Pittsburgh", "Philadelphia", "Baltimore"],
      ["Philadelphia", "Albany"] => ["Philadelphia", "New York", "Albany"],
	  ["Boston", "Albany"] => ["Boston", "New York", "Albany"],
	  ["Pittsburgh", "Albany"] => ["Pittsburgh", "New York", "Albany"],
	  ["Baltimore", "Albany"] => ["Baltimore", "New York", "Albany"]
	  
    }
  end
  
end