class Route < ActiveRecord::Base
belongs_to :cities
belongs_to :destination, :class_name => "City" 


end
