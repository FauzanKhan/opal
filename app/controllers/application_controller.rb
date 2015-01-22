class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_url
        flash[:danger] = "Please LogIn to access this page."
        redirect_to new_session_path
      end
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
