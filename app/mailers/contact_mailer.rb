class ContactMailer < ActionMailer::Base
  default :from => "site@directoryang.com"
  
  def send_message(email)
    @email = email
    mail(:to => "info@directoryang.com",
         :subject => "Message from Yang Website")
  end
end