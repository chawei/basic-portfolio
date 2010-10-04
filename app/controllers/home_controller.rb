class HomeController < ApplicationController
  def index
    @films = Film.public
  end
  
  def contact
    if request.post?
      ContactMailer.send_message(params['email']).deliver
    end
  end

end
