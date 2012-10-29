class Bus < ActiveRecord::Base
  belongs_to :cities
  belongs_to :trips
end
