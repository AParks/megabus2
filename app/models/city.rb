class City < ActiveRecord::Base
has_many :trips
# :foreign_key => 'leaving_from_id'
# :class_name => 'Trip', 
#has_many :trips_with_end, :class_name => 'Trip', :foreign_key => 'traveling_to_id'

#has_many :trips, :through => buses
validates :address, presence: true
validates :name, presence: true
attr_accessible :name, :address
end
 