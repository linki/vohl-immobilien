class MenuItem < ActiveRecord::Base
  
  belongs_to :page
  
  acts_as_ordered_tree :foreign_key => :parent_id,
                       :order       => :position
  
  before_validation :convert_parent_nil_to_zero
  
  named_scope :roots,
    :conditions => { :parent_id => 0 }
    
  named_scope :ordered,
    :order => :position
  
  def permalink
    page.nil? ? read_attribute('permalink') : page.permalink
  end
  
  def breadcrumbs
    ancestors.collect(&:name) << name
  end
  
  def root?
    parent.nil?
  end
  
protected
  
  def convert_parent_nil_to_zero
    self.parent_id = 0 if parent_id.blank?
  end

end
