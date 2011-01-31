class AlbumsController < ApplicationController  
  def index
    @albums = Album.published.paginate(:per_page => 8, :page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end
  
  def show
    @album = Album.published.find(params[:id])
    @photos = @album.photos.paginate(:per_page => 8, :page => params[:page])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end
  
end
