# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def link_to_delete(label, item)
    link_to label, item, :confirm => 'Sind Sie sicher?', :method => :delete
  end

  def admin?
    logged_in? && current_user.admin?
  end
  
  def adminarea
    yield if admin?
  end
  
  def string_if_zero(count, string = "no")
    count.zero? ? string : count
  end
  
  def link_to_toggle(label, element)
    link_to_function(label, nil) do |page|
      page[element].toggle
    end

  end

  def link_to_remote_if(condition, name, options = {}, html_options = {})
    if condition
      link_to_remote name, options, html_options
    else
      name
    end
  end
  
end
