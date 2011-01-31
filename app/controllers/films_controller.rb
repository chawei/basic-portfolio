class FilmsController < ApplicationController
  # GET /films
  # GET /films.xml
  def index
    if params[:type].blank?
      @films = Film.published.paginate(:per_page => 2, :page => params[:page])
    else
      @films = Film.published.find_all_by_film_type(params[:type].capitalize).paginate(:per_page => 2, :page => params[:page])
    end

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
  
end
