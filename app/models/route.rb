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
      "Philadelphia, PA" => 1,
      "Baltimore, MD" => 2,
      "Boston, MA"=> 3,
      "New York, NY" => 4,
      "Pittsburgh, PA"   => 5,
      "Cleveland, OH" => 6,
      "Amherst, MA" => 7,
      "Albany, NY" => 8                
    }
  end
  
  def self.multipoint_routes
    { 
      ["Pittsburgh, PA", "Baltimore, MD"]   => ["Pittsburgh, PA", "Philadelphia, PA", "Baltimore, MD"],
      ["Pittsburgh, PA", "Boston, MA"]   => ["Pittsburgh, PA", "Philadelphia, PA", "Boston, MA"],
      ["Philadelphia, PA", "Cleveland, OH"] => ["Philadelphia, PA", "Pittsburgh, PA", "Cleveland, OH"],
      ["Philadelphia, PA", "Amherst, MA"] => ["Philadelphia, PA", "New York, NY", "Amherst, MA"],
      ["Philadelphia, PA", "Albany, NY"] => ["Philadelphia, PA", "New York, NY", "Albany, NY"],
      ["Amherst, MA", "Albany, NY"] => ["Amherst, MA", "New York, NY", "Albany, NY"],
      ["Boston, MA", "Albany, NY"] => ["Boston, MA", "New York, NY", "Albany, NY"],
      ["Pittsburgh, PA", "Albany, NY"] => ["Pittsburgh, PA", "New York", "Albany, NY"],
      ["Baltimore, MD", "Albany, NY"] => ["Baltimore, MA", "New York, NY", "Albany,NY"],
      ["Cleveland, OH", "Albany, NY"] => ["Cleveland, OH", "Pittsburgh, PA", "New York, NY", "Albany, NY"]   	  
    }
  end
  
end