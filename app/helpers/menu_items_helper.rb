module MenuItemsHelper
  
  def breadcrumbs_for(menu_item)
    menu_item.breadcrumbs.join(' :: ') unless menu_item.nil?
  end
  
  def show_url(menu_item) # loftland, new_session_path
    if menu_item.page
      static_path(menu_item.page)
    else
      if menu_item.permalink.blank? 
        root_url 
      else
        if menu_item.permalink.include?('_path') || menu_item.permalink.include?('_url')
          send(menu_item.permalink)
        else
          menu_item.permalink
        end  
      end  
    end  
  end
  
  def popup_for(menu_item)
    if !menu_item.page && !menu_item.permalink.include?('_path') && !menu_item.permalink.include?('_url')
      if menu_item.name == "Bilder"
        [menu_item.name, 'height=700,width=600']
      else
        if menu_item.name == "Onlinebesichtigung"
          [menu_item.name, 'height=500,width=770']
        else
          [menu_item.name, 'height=700,width=820']
        end
      end
    else
      false
    end
  end
  
  ## muhaha, wie eklig...
  def current_menu?(menu_item)
    !menu_item.children.select{|c| c.page && current_page?(c.page)}.empty? ||
    !menu_item.children.select{|c| current_page?(:permalink => c.permalink)}.empty? ||
    menu_item.page && current_page?(menu_item.page) ||
    menu_item.page && current_page?(:permalink => menu_item.page.permalink) ||
      current_page?(:controller => 'downloads') && menu_item.permalink == "downloads_path" ||
      current_page?(:controller => 'downloads', :action => 'new') && menu_item.permalink == "downloads_path" ||
      current_page?(:controller => 'floorplans') && menu_item.permalink == "loftland" ||
      current_page?(contact_path) && menu_item.permalink == "contact_path" ||
      current_page?(login_path) && menu_item.permalink == "vertriebspartner" ||
      current_page?(signup_path) && menu_item.permalink == "vertriebspartner"
  end
end
