class AddMetadataToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :name, :string
    add_column :downloads, :description, :string
    add_column :downloads, :url, :string
    add_column :downloads, :category_id, :integer
    add_column :downloads, :created_at, :datetime
    add_column :downloads, :updated_at, :datetime
  end

  def self.down
    remove_column :downloads, :updated_at
    remove_column :downloads, :created_at
    remove_column :downloads, :category_id
    remove_column :downloads, :url
    remove_column :downloads, :description
    remove_column :downloads, :name
  end
end
