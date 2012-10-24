require 'spec_helper'

describe City do
	before(:each) do
		@city = City.new
	end

	it "requires address and " do
	#	debugger;1
		@city.should_not be_valid		
		@city.name = "Baltimore"
		@city.should_not be_valid
		@city.address = "station"		
		@city.should be_valid
	end

end
