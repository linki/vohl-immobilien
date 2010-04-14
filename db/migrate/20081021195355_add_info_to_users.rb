class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :salutation, :string
    add_column :users, :phone, :string
    add_column :users, :company, :string
  end

  def self.down
    remove_column :users, :company
    remove_column :users, :phone
    remove_column :users, :salutation
  end
end
