class ContactPerson < ActiveRecord::Base
  
  def name_with_position
    "#{name} - #{position}"
  end

end
