class City < ActiveRecord::Base
has_many :trips

	attr_accessible :name ,:id, :address
	validates :address, presence: true
	validates :name, presence: true
end
 