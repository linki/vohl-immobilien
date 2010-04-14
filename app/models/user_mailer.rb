class UserMailer < ActionMailer::Base

  def reset_notification(user)
    setup_email(user)
    @subject    += 'Link um Ihr Passwort zurückzusetzen'
    @body[:url]  = "#{APP_CONFIG[:domain]}/reset/#{user.reset_code}"
  end

  def registration_notification(user)
    @recipients  = "#{APP_CONFIG[:webmaster]}"
    @from        = "#{APP_CONFIG[:webmaster]}"
    @subject     = "[VOHL] "
    @sent_on     = Time.now
    @body[:user] = user
    @subject    += 'Neuer Account. Bitte aktivieren'
    @body[:url]  = "#{APP_CONFIG[:domain]}/activate/#{user.activation_code}"
  end
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Account wurde erstellt'
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Ihr Account wurde aktiviert'
    @body[:url]  = "#{APP_CONFIG[:domain]}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{APP_CONFIG[:webmaster]}"
      @subject     = "[VOHL] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
