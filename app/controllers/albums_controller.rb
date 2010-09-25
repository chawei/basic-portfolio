class AlbumsController < ApplicationController  
  def index
    @albums = Album.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end
  
  def show
    @album = Album.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end
  
end
