class ChangeTrips2 < ActiveRecord::Migration
    def change
	
		drop_table :trips
	
		create_table :trips do |t|
			t.integer :number_of_passengers
			t.references :leaving_from
			t.references :traveling_to
			t.date :outbound_date
			t.date :return_date

			t.timestamps
		end
	
	end

end
