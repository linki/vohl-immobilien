class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :name
      t.integer :parent_id, :null => false , :default => 0
      t.integer :position
      t.integer :page_id
      t.timestamps
    end
    
    add_index :menu_items, :parent_id
  end
  
  def self.down
    drop_table :menu_items
  end
end
