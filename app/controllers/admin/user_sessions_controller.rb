class Admin::UserSessionsController < AdminController
  before_filter :require_no_user, :only => [:create]
  before_filter :require_user, :only => :destroy
    
  def new
    redirect_to admin_url if current_user_session
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to admin_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_admin_user_session_url
  end
end