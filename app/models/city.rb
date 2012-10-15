class City < ActiveRecord::Base
has_many :trips
#has_many :routes
#has_many :destinations, :through => routes
attr_accessible :name, :address
end
 