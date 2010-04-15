# coding: utf-8
class PagesController < ApplicationController
  
  require_role "admin", :for_all_except => :show
  
  def index
    @pages = Page.find(:all)
  end
  
  def show
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, "Page not found" if @page.nil?
    else
      @page = Page.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound, "Page not found" if @page.nil?
    end  
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Die Seite wurde erfolgreich erstellt."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find_by_permalink(params[:id])
  end
  
  def update
    @page = Page.find_by_permalink(params[:id])
    ## startseiten-hack
    if @page.startpage? && params[:page][:permalink] != "helm_und_vohl"
      @page.attributes = params[:page].except(:permalink)
      flash[:error] = "Der Permalink der Startseite (helm_und_vohl) kann zur Zeit nicht geändert werden"
      render :action => 'edit'
    else
      if @page.update_attributes(params[:page])
        flash[:notice] = "Die Seite wurde erfolgreich überarbeitet."
        redirect_to @page
      else
        render :action => 'edit'
      end
    end
  end
  
  def destroy
    @page = Page.find_by_permalink(params[:id])
    @page.destroy
    flash[:notice] = "Die Seite wurde erfolgreich gelöscht."
    redirect_to root_url
  end
  
  protected
  
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
