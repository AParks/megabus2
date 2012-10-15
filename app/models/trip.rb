class Trip < ActiveRecord::Base
belongs_to :city
attr_accessible :number_of_passengers, :leaving_from, :traveling_to, :outbound_date, :return_date
end
