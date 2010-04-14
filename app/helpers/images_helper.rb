module ImagesHelper
  
  def image(name, options = {})
    options.reverse_merge! :size => "16x16"
    image_tag "#{name}", options
  end
  
  def delete_image
    image "cancel_f2.png" #, :mouseover => "cancel_f2.png"
  end 
  
  def edit_image
    image "edit_f2.png" #, :mouseover => "edit_f2.png"
  end
  
  def new_image
    image "new.png"
  end  
  
   def up_image
    image "up.png"
  end 
  
  def down_image
    image "down.png"
  end 
  
end
