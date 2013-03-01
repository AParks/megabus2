class City < ActiveRecord::Base
has_many :trips

  attr_accessible :name
  
#has_many :trips, :through => buses
validates :address, presence: true
validates :name, presence: true
attr_accessible :name, :address
end
 