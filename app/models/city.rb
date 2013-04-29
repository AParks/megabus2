class City < ActiveRecord::Base
has_many :trips

	attr_accessible :name ,:id, :megabusID, :timezone
	validates :name, presence: true
	validates :timezone, presence: true

end
 