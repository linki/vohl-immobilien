class Page < ActiveRecord::Base
  
  has_one :menu_item
  
  validates_presence_of :permalink
  validates_uniqueness_of :permalink
  
  liquid_methods :categories
  
  def to_param
    permalink
  end
  
  def categories
	Category.find(:all)
  end
  
  def startpage?
     permalink == "helm_und_vohl"
  end
  
end
