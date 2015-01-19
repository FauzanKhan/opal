class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
  	@user = Tpo.find_by(email: params[:password_reset][:email].downcase) || Student.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
      	@user.send_password_reset_email
  		flash[:info] = "An email has been sent to you with password rest instructions"
  		redirect_to root_path
  	else
  		flash[:danger] = "Email ID not found. Please check your email Id and try again"
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.user_type == 'tpo'
      if password_blank?
        flash.now[:danger] = "Password can't be blank"
        render 'edit'
      elsif @user.update_attributes(tpo_params)
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
      else
        render 'edit'
      end
    elsif @user.user_type == 'student'
      if password_blank_stu?
        flash.now[:danger] = "Password can't be blank"
        render 'edit'
      elsif @user.update_attributes(stu_params)
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
      else
        render 'edit'
      end
    end

  end

  private
    def get_user
      @user = Tpo.find_by(email: params[:email]) || Student.find_by(email: params[:email])
    end

    def valid_user
      unless ( @user && @user.activated && @user.authenticated?(:reset, params[:id]) )
        redirect_to root_url
      end
    end

    def tpo_params
      params.require(:tpo).permit(:password)
    end

    def stu_params
      params.require(:student).permit(:password)
    end

    # Returns true if password is blank.
    def password_blank?
      params[:tpo][:password].blank?
    end

    def password_blank_stu?
      params[:student][:password].blank?
    end

    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end
