class Admin::AlbumsController < AdminController  
  def index
    @albums = Album.all.paginate(:per_page => 6, :page => params[:page])
    
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
  
  def new
    @album = Album.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end
  
  def create
    @album = Album.new(params[:album])
    
    respond_to do |format|
      if @album.save
        format.html do 
          flash[:notice] = "Successfully created album."
          if params[:album][:album_cover].blank?
            redirect_to [:admin, @album]
          else
            render :action => "crop"
          end
        end
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:notice] = "Successfully updated album."
      if params[:album][:album_cover].blank?
        redirect_to [:admin, @album]
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Successfully destroyed album."
    redirect_to admin_albums_url
  end
  
  def crop
    photo = Photo.find(params[:photo_id])
    @album = Album.find(params[:id])
    if @album.album_cover_photo_id != photo.id
      @album.album_cover_photo_id = photo.id
      @album.album_cover = File.new(photo.data.path(:medium))
      @album.save
    end      
  end
  
  def delete_photo
    photo = Photo.find(params[:photo_id])
    photo.destroy
    @album = Album.find(params[:id])
    if request.xhr?
      render :nothing => true
    else
      redirect_to [:admin, @album]
    end
  end
  
  def sort
    @albums = Album.all
    @albums.each do |album|
      album.position = params['album'].index(album.id.to_s) + 1
      album.save
    end
    render :nothing => true
  end
  
  def toggle_published
    @album = Album.find(params[:id])
    @album.toggle_published
    respond_to do |format|
      format.json { render :json => { :status => 'success', :text => (@album.hidden? ? 'Publish' : 'Hide') } }
    end
  end
end
