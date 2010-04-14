class ContactPeopleController < ApplicationController
  
  require_role "admin"
  
  def index
    @contact_people = ContactPerson.find(:all)
  end
  
  def show
    @contact_person = ContactPerson.find(params[:id])
  end
  
  def new
    @contact_person = ContactPerson.new
  end
  
  def create
    @contact_person = ContactPerson.new(params[:contact_person])
    if @contact_person.save
      flash[:notice] = "Contact Person erfolgreich erstellt."
      redirect_to @contact_person
    else
      render :action => 'new'
    end
  end
  
  def edit
    @contact_person = ContactPerson.find(params[:id])
  end
  
  def update
    @contact_person = ContactPerson.find(params[:id])
    if @contact_person.update_attributes(params[:contact_person])
      flash[:notice] = "Contact Person erfolgreich bearbeitet."
      redirect_to @contact_person
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @contact_person = ContactPerson.find(params[:id])
    @contact_person.destroy
    flash[:notice] = "Contact Person erfolgreich gelöscht."
    redirect_to contact_people_url
  end
end
