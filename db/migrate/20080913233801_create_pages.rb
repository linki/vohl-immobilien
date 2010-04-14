class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :permalink, :null => false, :default => 'index'
      t.text :content
      t.timestamps
    end
    
    add_index :pages, :permalink, :unique => true 
  end
  
  def self.down
    drop_table :pages
  end
end
