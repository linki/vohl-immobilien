class UsersController < ApplicationController

  require_role "admin",
    :for_all_except => [ :new, :create, :forgot, :reset ]
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Vielen Dank für Ihre Registrierung. Ihr Account wird innerhalt von 24 Stunden freigeschaltet. Sie erhalten dann nochmal eine Email von uns."
    else
      #flash[:error]  = "Wir konnten Ihren Account nicht anlegen. Bitte versuchen Sie es erneut."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Der Benutzer wurde erfolgreich aktiviert."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "Der Registrierungscode fehlt. Bitte benutzen Sie die URL aus der Email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "Der Aktivierungscode konnte nicht gefunden werden. Überprüfen Sie Ihre Emails. Oder vielleicht wurde der Account schon aktiviert."
      redirect_back_or_default('/')
    end
  end
  
  def index
    @users = User.find(:all)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    params[:user][:role_ids] ||= []
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Der Benutzer wurde erfolgreich überarbeitet."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Der Benutzer wurde erfolgreich gelöscht"
    redirect_to users_url
  end  
  
  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:notice] = "Eine Email mit dem Reset Code wurde an #{user.email} verschickt"
      else
        flash[:error] = "#{params[:user][:email]} gibt es nicht"
      end
      redirect_back_or_default('/')
    end
  end
  
  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if @user
      if request.post?
        if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
          self.current_user = @user
          @user.delete_reset_code
          flash[:notice] = "Passwort erfolgreich geändert für #{@user.email}"
          redirect_back_or_default('/')
        else
          render :action => :reset
        end
      end
    else
      redirect_back_or_default('/')
    end      
  end
  
  protected
  
  def current_page
    @current_page = nil
  end
  
  def current_menu_item
    @current_menu_item ||= MenuItem.find_by_name("Vertriebspartner-Login")
  end  
  
end
