class Download < ActiveRecord::Base
  
  #has_attachment :content_type => ['application/pdf', 'application/msword', 'text/plain', :image],
  #               :storage => :file_system, 
  #               :max_size => 5000.kilobytes,
  #               :resize_to => '3200x2000>',
  #               :thumbnails => { :thumb => '100x100>' }

  #validates_as_attachment
  
  belongs_to :category
  
  validates_presence_of :category

  attr_accessor :new_category_name
  
  before_validation :create_category_from_name

  liquid_methods :name
  
  def create_category_from_name
    create_category(:name => new_category_name) unless new_category_name.blank?
  end
  
end
