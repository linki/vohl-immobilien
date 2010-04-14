class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :type
      t.string :name
      t.string :permalink
      t.text :content
      t.boolean :published
      t.timestamps
    end
  end
  
  def self.down
    drop_table :items
  end
end
