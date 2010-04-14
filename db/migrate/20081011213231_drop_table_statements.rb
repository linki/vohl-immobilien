class DropTableStatements < ActiveRecord::Migration
  def self.up
	drop_table :statements
  end

  def self.down
    create_table :statements do |t|
      t.string :name
      t.text :content
      t.boolean :published
      t.timestamps
    end  
  end
end
