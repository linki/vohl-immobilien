class AddPositionToFloorplan < ActiveRecord::Migration
  def self.up
    add_column :floorplans, :square_meters, :integer
    add_column :floorplans, :position, :integer
    
    i = 1
    for floorplan in Floorplan.all do
      floorplan.update_attribute(:position, i)
      i = i + 1
    end
  end

  def self.down
    remove_column :floorplans, :position
    remove_column :floorplans, :square_meters
  end
end
