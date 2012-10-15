class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :number_of_passengers
      t.string :leaving_from
      t.string :traveling_to
      t.date :outbound_date
      t.date :return_date

      t.timestamps
    end
  end
end
