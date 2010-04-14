class RemoveMetadataFromDownloads < ActiveRecord::Migration
  def self.up
    remove_column :downloads, :parent_id
    remove_column :downloads, :content_type
    remove_column :downloads, :filename
    remove_column :downloads, :thumbnail
    remove_column :downloads, :size
    remove_column :downloads, :width
    remove_column :downloads, :height
    remove_column :downloads, :created_at
    remove_column :downloads, :updated_at
  end

  def self.down
    add_column :downloads, :updated_at, :datetime
    add_column :downloads, :created_at, :datetime
    add_column :downloads, :height, :integer
    add_column :downloads, :width, :integer
    add_column :downloads, :size, :integer
    add_column :downloads, :thumbnail, :string
    add_column :downloads, :filename, :string
    add_column :downloads, :content_type, :string
    add_column :downloads, :parent_id, :integer
  end
end
