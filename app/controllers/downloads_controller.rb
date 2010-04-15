# coding: utf-8
class DownloadsController < ApplicationController
  
  require_role "admin",
    :for_all_except => [ :index, :show ]
    
  require_role "partner",
    :for => :show
  
  after_filter :delete_empty_categories, :only => [ :update, :delete ]
  
  def index
    store_location
    @categories = Category.find(:all, :order => 'name')
  end
  
  def show
    @download = Download.find(params[:id])
  end
  
  def new
    @download = Download.new
  end
  
  def create
    @download = Download.new(params[:download])
    if @download.save
      flash[:notice] = "Der Download wurde erfolgreich erstellt."
      redirect_to downloads_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @download = Download.find(params[:id])
  end
  
  def update
    @download = Download.find(params[:id])
    if @download.update_attributes(params[:download])
      flash[:notice] = "Der Download wurde erfolgreich überarbeitet."
      redirect_to downloads_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @download = Download.find(params[:id])
    @download.destroy
    flash[:notice] = "Der Download wurde erfolgreich gelöscht."
    redirect_to downloads_url
  end
  
  protected
  
  def current_page
    @current_page = nil
  end
  
  def current_menu_item
    @current_menu_item ||= MenuItem.find_by_name("Downloads")
  end
  
  def delete_empty_categories
    Category.empty.each(&:destroy)
  end
end
