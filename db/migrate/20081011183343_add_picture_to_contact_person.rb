class AddPictureToContactPerson < ActiveRecord::Migration
  def self.up
    add_column :contact_people, :picture_url, :string
  end

  def self.down
    remove_column :contact_people, :picture_url
  end
end
