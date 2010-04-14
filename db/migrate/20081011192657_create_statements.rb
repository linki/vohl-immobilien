class CreateStatements < ActiveRecord::Migration
  def self.up
    create_table :statements do |t|
      t.string :name
      t.text :content
      t.boolean :published
      t.timestamps
    end
  end
  
  def self.down
    drop_table :statements
  end
end
