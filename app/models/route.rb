class Route
  def initialize(points)
    @points = points
  end
  
  def reverse
    @points.reverse
  end
  
  def points
	@points
	end
  
  def self.name_to_id
    { 
      "Philadelphia,PA" => 1,
      "Baltimore, MD" => 2,
      "Boston, MA"=> 3,
      "New York, NY" => 4,
      "Pittsburgh, PA"   => 1,
      "Cleveland, OH" => 4,
      "Amherst, MA" => 7        
    }
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