require 'spec_helper'

describe "Trips" do
  describe "GET /trips" do
  
  fixtures :cities
  before do 
		visit new_trip_path
	end
	
	it "error", js: true do
		select "Baltimore", from: "Leaving from"
		select "Baltimore", from: "Traveling to"
		click_button "Create Trip"

      error_message = "You cannot have the same start and end city"
      page.should have_content(error_message)
    end
	  
    it "create trips", js: true do 	  
		select "Baltimore", from: "Leaving from"
		select "Philadelphia", from: "Traveling to"
		click_button "Create Trip"
		page.should have_content "successful"
    end
  end
end
