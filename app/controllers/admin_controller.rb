class AdminController < ApplicationController
  layout 'admin'
  before_filter :require_user
  
  before_filter :in_admin
  helper_method :in_admin?
  
  def in_admin?
    @in_admin ||= false
  end
  
  private
    def in_admin
      @in_admin = true
    end
end