class AddPermalinkToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :permalink, :string
  end

  def self.down
    remove_column :menu_items, :permalink
  end
end
