class FloorplansController < ApplicationController
  
  require_role "admin",
    :for_all_except => :index
  
  in_place_edit_for :floorplan, :status
  
  def index
    store_location
    @floorplans = Floorplan.ordered
	
    respond_to do |format|
      format.html
      format.xml { render :xml => @floorplans.to_xml(:only => [ :name, :kind, :location, :status, :file_url ]) }
    end
  end
  
  def show
    @floorplan = Floorplan.find(params[:id])
  end
  
  def new
    @floorplan = Floorplan.new
  end
  
  def create
    @floorplan = Floorplan.new(params[:floorplan])
    if @floorplan.save
      flash[:notice] = "Der Grundriss wurde erfolgreich erstellt."
      redirect_to floorplans_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @floorplan = Floorplan.find(params[:id])
  end
  
  def update
    @floorplan = Floorplan.find(params[:id])
    if @floorplan.update_attributes(params[:floorplan])
      flash[:notice] = "Der Grundriss wurde erfolgreich überarbeitet."
      redirect_to floorplans_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @floorplan = Floorplan.find(params[:id])
    @floorplan.destroy
    flash[:notice] = "Der Grundriss wurde erfolgreich gelöscht."
    redirect_to floorplans_url
  end
  
  def up
    @floorplan = Floorplan.find(params[:id])
    @floorplan.move_higher
    redirect_to floorplans_path
  end
  
  def down
    @floorplan = Floorplan.find(params[:id])
    @floorplan.move_lower
    redirect_to floorplans_path
  end
  
protected

  def current_page
    @current_page = nil
  end
  
  def current_menu_item
    @current_menu_item ||= MenuItem.find_by_name("Grundrisse")
  end
end
