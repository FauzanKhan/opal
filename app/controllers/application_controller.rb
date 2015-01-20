class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper

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
