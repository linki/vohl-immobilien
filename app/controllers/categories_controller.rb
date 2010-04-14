class CategoriesController < ApplicationController
  
  require_role "admin"
  
  def index
    @categories = Category.find(:all)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Category erfolgreich erstellt."
      redirect_to @category
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category erfolgreich bearbeitet."
      redirect_to downloads_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category erfolgreich gelöscht."
    redirect_to categories_url
  end
end
