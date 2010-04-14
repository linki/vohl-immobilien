class MenuItemsController < ApplicationController
  
  require_role "admin"
  
  def index
    @menu_items = MenuItem.roots.ordered.find(:all)
  end
  
  def show
    @menu_item = MenuItem.find(params[:id])
  end
  
  def new
    @menu_item = MenuItem.new
  end
  
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    if @menu_item.save
      flash[:notice] = "Das Menü wurde erfolgreich erstellt."
      redirect_to @menu_item
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu_item = MenuItem.find(params[:id])
  end
  
  def update
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.update_attributes(params[:menu_item])
      flash[:notice] = "Das Menü wurde erfolgreich überarbeitet."
      redirect_to @menu_item
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    flash[:notice] = "Das Menü wurde erfolgreich gelöscht."
    redirect_to menu_items_url
  end
end
