class ContactMessagesController < ApplicationController
  
  require_role "admin",
    :for_all_except => [ :new, :create ]
  
  before_filter :find_contact_people, :only => [ :new, :create, :edit, :update ]
  
  def index
    @contact_messages = ContactMessage.find(:all)
  end
  
  def show
    @contact_message = ContactMessage.find(params[:id])
  end
  
  def new
    @contact_message = ContactMessage.new
    if logged_in?
      @contact_message.name = current_user.name
	    @contact_message.company = current_user.company
      @contact_message.email = current_user.email
    end
  end
  
  def create
    @contact_message = ContactMessage.new(params[:contact_message])
    if @contact_message.save ## or dont save it: valid?
      Mailer.deliver_contact_message(@contact_message)
      Mailer.deliver_contact_message_confirmation(@contact_message)
      flash[:notice] = "Ihre Nachricht wurde erfolgreich versandt."
	  redirect_to contact_path
    else
      flash[:error] = "Ihre Nachricht war nicht vollständig und wurde nicht versandt."
	  render :action => 'new'
    end
  end
  
  def edit
    @contact_message = ContactMessage.find(params[:id])
  end
  
  def update
    @contact_message = ContactMessage.find(params[:id])
    if @contact_message.update_attributes(params[:contact_message])
      flash[:notice] = "Die Kontaktnachricht erfolgreich überarbeitet."
      redirect_to @contact_message
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @contact_message = ContactMessage.find(params[:id])
    @contact_message.destroy
    flash[:notice] = "Die Kontaktnachricht wurde erfolgreich gelöscht."
    redirect_to contact_messages_url
  end
  
protected

  def find_contact_people
    @contact_people = ContactPerson.find(:all)
  end

  def current_page
    @current_page = nil
  end
  
  def current_menu_item
    @current_menu_item ||= MenuItem.find_by_name("Kontakt")
  end  
end
