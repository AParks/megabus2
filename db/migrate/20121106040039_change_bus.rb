class ChangeBus < ActiveRecord::Migration
  def up 
  end

  def change
	drop_table :buses
	create_table :buses do |t|
		t.decimal :price
		t.time :leave_time
		t.time :arrival_time
		t.references :leaving_from
		t.references :traveling_to
		t.belongs_to :cities
		t.belongs_to :trips	
	
	end
end
  
  def down
  end
end
