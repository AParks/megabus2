class Bus < ActiveRecord::Base

 attr_accessible :leaving_from, :traveling_to, :leave_time, :arrival_time, :price 

 belongs_to :leaving_from, :class_name => "City"  
 belongs_to :traveling_to, :class_name => "City"



end
