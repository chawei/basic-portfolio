class Admin::VideosController < AdminController

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])
    @video.associate_id = params[:associate_id]

    respond_to do |format|
      if @video.save
        format.html { redirect_to([:admin, @video], :notice => 'Video was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
        format.json { render :text => 'ok' }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
        format.json { render :text => 'fail' }
      end
    end
  end

end
