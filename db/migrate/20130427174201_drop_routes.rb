class DropRoutes < ActiveRecord::Migration
  def up
  	drop_table :routes
  end

  def down
  end
end
