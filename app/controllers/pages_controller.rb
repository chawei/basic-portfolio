class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all_custom_pages

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html { render :template => "pages/#{@page.unique_name}" }
      format.xml  { render :xml => @page }
    end
  end
  
  protected

    def invalid_page
      render :nothing => true, :status => 404
    end

    def current_page
      "pages/#{params[:id].to_s.downcase}"
    end

end
