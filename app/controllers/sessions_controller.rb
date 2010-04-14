# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # before_filter :cookies_required, :except => "cookies_test"

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Sie haben sich erfolgreich eingeloggt."
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Sie haben sich erfolgreich ausgeloggt."
    redirect_back_or_default('/')
  end
  
  def cookies_test
    if request.cookies["_session_id"].to_s.blank?
      logger.warn("=== cookies are disabled")
      redirect_to static_path(:permalink => 'cookies_required')
    else
      redirect_back_or_default(:controller => 'pages', :action => 'show', :id => 'helm_und_vohl')
    end
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Der Einloggversuch mit dem Namen '#{params[:login]}' ist fehlgeschlagen."
    flash.discard
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
    @login_failed = true
  end
  
  def current_page
    @current_page = nil
  end
  
  def current_menu_item
    @current_menu_item ||= MenuItem.find_by_name("Vertriebspartner-Login")
  end  
  
  def cookies_required
    return unless request.cookies["_mackes_session"].to_s.blank?
    session[:return_to] = request.request_uri
    redirect_to(:controller => "sessions",  :action => "cookies_test")
    return false
  end
end
