class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.decimal :price
      t.time :leave_time
      t.time :arrival_time
      t.belongs_to :cities
      t.belongs_to :trips

      t.timestamps
    end
    add_index :buses, :cities_id
    add_index :buses, :trips_id
  end
end
