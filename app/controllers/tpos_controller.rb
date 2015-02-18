class TposController < ApplicationController

	#before_action :admin_user, only: [:index]
	before_action :logged_in_user, only: [:edit, :update, :show]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy, :index]
	before_action :redirect_if_logged_in, only: [:new]

	include TposHelper

	def new
		@tpo = Tpo.new
	end

	def index
		@tpos = Tpo.all - Tpo.where(admin: true)
	end

	def show
		redirect_to admin_panel_path if current_user.user_type == 1 && current_user.admin
		@tpo = Tpo.find(params[:id])
		@jobposts = @tpo.jobposts
	end

	def update
		@tpo = Tpo.find(params[:id])
		#old_email = @tpo.email
		#new_email = params[:tpo][:email]
		#update_all_user(old_email, new_email)
		if @tpo.update_attributes(update_tpo_params)
			flash[:success] = "Profile updated"
      		redirect_to @tpo
		else
			render 'edit'
		end
	end

	def create
		@tpo = Tpo.new(tpo_params)
		@tpo.first_name = params[:tpo][:first_name].titleize
		@tpo.last_name = params[:tpo][:last_name].titleize
		@tpo.college = params[:tpo][:college].titleize
		if @tpo.save
			#log_in @tpo
			@tpo.send_activation_email
			flash[:info] = "Please check your email to activate your account"
			redirect_to root_url #@tpo
		else
			render 'new'
		end
	end

	def edit
		@tpo = Tpo.find(params[:id])
	end

	def destroy
		tpo = Tpo.find(params[:id])
		college_id = tpo.college_id
		college = College.find(college_id)
		if college.destroy && tpo.destroy
			update_student_colleges(college_id)
			flash[:success] = "Tpo & corresponding college deleted"
			redirect_to :back
		end
	end
	
	private
		def tpo_params
			params.require(:tpo).permit(:email, :password, :first_name, :last_name, :college, :location_id)
		end

		def update_tpo_params
			params.require(:tpo).permit(:password, :first_name, :last_name, :job_title, :image)
		end

		def correct_user
			@user = Tpo.find(params[:id])
			if !(@user == current_user)
				redirect_to root_path
				flash[:danger] = "Action not allowed as you're not the owner of requested profile"
			end
		end

		#def update_all_user(old_email, new_email)
		#	@user = AllUser.find_by(email: old_email)
		#	@user.update_column(:email, new_email)
		#end
end
