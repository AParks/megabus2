class ChangeTrips < ActiveRecord::Migration
  def change
	remove_column :trips, :leaving_from
	remove_column :trips, :traveling_to

	add_column :trips, :leaving_from_id, :integer
	add_column :trips, :traveling_to_id, :integer
	end
 

end
