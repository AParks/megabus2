class Trip < ActiveRecord::Base
  attr_accessible :number_of_passengers, :leaving_from_id, :leaving_from, :traveling_to, :traveling_to_id, :outbound_date, :return_date

  belongs_to :leaving_from, :class_name => "City"  
  belongs_to :traveling_to, :class_name => "City"
  
  #has_many :cities, :through => buses 
  validates_date :outbound_date, :on => :create, :on_or_after => :today
  validates_date :outbound_date, :on => :create, :on_or_before => :return_date

  validates :number_of_passengers, presence: true
  
  validate :cannot_have_same_start_end

  def cannot_have_same_start_end
	if self.leaving_from_id == self.traveling_to_id
		errors.add(:leaving_from, "You cannot have the same start and end city." )
		errors.add(:traveling_to, "" )
	end
  end
  
    
  def route
    points = [leaving_from.name, traveling_to.name]
    
    if multipoints = Route.multipoint_routes(points)
      Route.new(multipoints)
    elsif multipoints = Route.multipoint_routes(points.reverse)
      Route.new(multipoints.reverse)
    else
      Route.new(points)
    end
  end
  
end
