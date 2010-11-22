class Admin::PhotosController < AdminController
    
  def index
    @photos = Photo.all(:conditions => ['imageable_type = ?', 'Attachment'])
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      redirect_to [:admin, @photo]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @photo = Photo.find(params[:id])
    unless @album = @photo.album
      redirect_to admin_albums_path 
    end
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to [:admin, @photo]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    if @photo.album and (@photo.lower_item or @photo.higher_item)
      @album = @photo.album
      @redirect_photo = @photo.lower_item || @photo.higher_item
    end
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    respond_to do |format|
      format.html do
        if @album and @redirect_photo
          redirect_to edit_admin_album_photo_path(@album, @redirect_photo)
        else
          redirect_to album_albums_path
        end
      end
      format.js { render :nothing => true }
    end
  end
  
  def sort
    params["photo"].each_with_index do |id, index|
      Photo.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
