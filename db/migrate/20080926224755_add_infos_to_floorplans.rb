class AddInfosToFloorplans < ActiveRecord::Migration
  def self.up
    add_column :floorplans, :price_per_meter, :decimal, :precision => 8, :scale => 2
    add_column :floorplans, :full_price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :floorplans, :full_price
    remove_column :floorplans, :price_per_meter
  end
end
