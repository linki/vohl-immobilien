class CreateFloorplans < ActiveRecord::Migration
  def self.up
    create_table :floorplans do |t|
      t.string :name
      t.string :kind
      t.string :location
      t.string :status
      t.string :file_url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :floorplans
  end
end
