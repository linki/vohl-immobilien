# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  local_addresses.clear


  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '9c3c27466469af50fa57638fe78433d5'
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  before_filter :load_menu_items, :current_page, :current_menu_item
  
protected
  
  def load_menu_items
    @menu_items = MenuItem.roots.ordered.find(:all)
  end
  
  def current_page
    if params[:permalink]
      @current_page ||= Page.find_by_permalink(params[:permalink]) 
    else
      @current_page ||= Page.find_by_permalink(params[:id]) if params[:id]
    end
  end
  
  def current_menu_item
    @current_menu_item ||= current_page.menu_item if current_page
  end
end
