class Category < ActiveRecord::Base
  
  has_many :downloads, :order => 'name'
  
  liquid_methods :name, :description, :downloads
  
  def self.empty
    Category.find(:all, :conditions => [ 'id NOT IN (?)', Download.find(:all).collect(&:category_id) ] )
  end
  
end
