class HomeController < ApplicationController
  def index
    @films = Film.published
  end
  
  def contact
    if request.post?
      ContactMailer.send_message(params['email']).deliver
    end
  end

end
