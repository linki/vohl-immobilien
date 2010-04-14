class Mailer < ActionMailer::Base

  def contact_message(contact_message)
    subject    "[VOHL] Neue Kontaktnachricht"
    if contact_message.recipient.blank? 
      recipients APP_CONFIG[:webmaster]
    else
      recipients contact_message.recipient
    end  
    from       contact_message.email
    body       :contact_message => contact_message
  end
  
  def contact_message_confirmation(contact_message)
    subject    "[VOHL] Ihre Kontaktnachricht"
    recipients contact_message.email 
    from       APP_CONFIG[:webmaster]
    body       :contact_message => contact_message
  end 
end
