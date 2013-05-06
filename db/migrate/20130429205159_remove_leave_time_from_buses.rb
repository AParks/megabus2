class RemoveLeaveTimeFromBuses < ActiveRecord::Migration
  def up
  end


  def change
	drop_table :buses
		create_table :buses do |t|
			t.decimal :price
			t.datetime :leave_time
			t.datetime :arrival_time
			t.references :leaving_from
			t.references :traveling_to
		end
	end

  def down
  end
end
