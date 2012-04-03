class Admin::FilmsController < AdminController
  #skip_before_filter :verify_authenticity_token, :only => [:create, :update]
  
  # GET /films
  # GET /films.xml
  def index
    @films = Film.all.paginate(:per_page => 6, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @films }
    end
  end

  # GET /films/1
  # GET /films/1.xml
  def show
    @film = Film.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @film }
    end
  end

  # GET /films/new
  # GET /films/new.xml
  def new
    @film = Film.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @film }
    end
  end

  # GET /films/1/edit
  def edit
    @film = Film.find(params[:id])
  end

  # POST /films
  # POST /films.xml
  def create
    @film = Film.new(params[:film])
    @film.video = Video.find_by_associate_id(params[:associate_id])

    respond_to do |format|
      if @film.save
        format.html { redirect_to([:admin, @film], :notice => 'Film was successfully created.') }
        format.xml  { render :xml => @film, :status => :created, :location => @film }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @film.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /films/1
  # PUT /films/1.xml
  def update
    @film = Film.find(params[:id])
    if video = Video.find_by_associate_id(params[:associate_id])
      @film.video = video
    end
    respond_to do |format|
      if @film.update_attributes(params[:film])
        format.html { redirect_to([:admin, @film], :notice => 'Film was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @film.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.xml
  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    respond_to do |format|
      format.html { redirect_to(admin_films_url) }
      format.xml  { head :ok }
    end
  end
  
  def toggle_published
    @film = Film.find(params[:id])
    @film.toggle_published
    respond_to do |format|
      format.json { render :json => { :status => 'success', :text => (@film.hidden? ? 'Publish' : 'Hide') } }
    end
  end
end
