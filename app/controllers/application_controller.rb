class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :add_home_breadcrumb
  
  def add_home_breadcrumb
    add_breadcrumb 'Home', home_path if user_signed_in?
  end

end
