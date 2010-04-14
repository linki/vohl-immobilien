class Floorplan < ActiveRecord::Base
  
  acts_as_list
  
  named_scope :ordered, :order => :position
  
end
