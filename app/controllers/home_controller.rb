class HomeController < ApplicationController
  def index
    @film = Film.first
  end

end
