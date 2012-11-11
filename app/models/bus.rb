class Bus < ActiveRecord::Base

belongs_to :trip
 belongs_to :leaving_from, :class_name => "City"  
  belongs_to :traveling_to, :class_name => "City"

scope :cheap, order('price asc').limit(1)  
 
end
