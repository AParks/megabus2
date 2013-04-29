class AddmegabusIdToCities < ActiveRecord::Migration
  def up
  end



  def change
	drop_table :cities
		create_table :cities do |t|
			t.string :name
	      	t.integer :megabusID
	      	t.string :timezone
	      	t.timestamps
		end
	end

  def down
  end
end
