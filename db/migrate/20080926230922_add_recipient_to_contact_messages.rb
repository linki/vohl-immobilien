class AddRecipientToContactMessages < ActiveRecord::Migration
  def self.up
    add_column :contact_messages, :recipient, :string
  end

  def self.down
    remove_column :contact_messages, :recipient
  end
end
