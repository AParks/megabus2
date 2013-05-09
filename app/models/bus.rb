class Bus < ActiveRecord::Base

 attr_accessible :leaving_from, :traveling_to, :leave_time, :arrival_time, :price 

 belongs_to :leaving_from, :class_name => "City"  
 belongs_to :traveling_to, :class_name => "City"

	validates :leaving_from, presence: true
	validates :traveling_to, presence: true
	validates :arrival_time, presence: true
	validates :leave_time, presence: true
	validates_time :leave_time, :before => :arrival_time, :before_message => self.price
	validates :price, presence: true


end
