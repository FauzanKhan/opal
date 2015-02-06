class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_cache_buster
  
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_url
        flash[:danger] = "Please LogIn to access this page."
        redirect_to new_session_path
      end
  end

  def redirect_if_logged_in
    if !current_user.nil?
      redirect_to current_user
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  layout :layout_selection
  private
  def layout_selection
    if current_user.nil?
      "application"
    else
      "member_layout"
    end
  end

end
