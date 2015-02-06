class TposController < ApplicationController

	#before_action :admin_user, only: [:index]
	before_action :logged_in_user, only: [:edit, :update, :show]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user,     only: [:destroy, :index]
	before_action :redirect_if_logged_in, only: [:new]

	def new
		@tpo = Tpo.new
	end

	def index
		@users = AllUser.all
		#users_hash = Hash.new()
		#n = 1
		#@users.each do |user|
		#	users_hash[n.to_s][:name] = user.name
		#	users_hash[n.to_s][:email] = user.email
		#	users_hash[n.to_s][:college] = user.college
		#	users_hash[n.to_s][:type] = user.user_type
		#	n += 1
		#end
		#=end
	end

	def show
		@tpo = Tpo.find(params[:id])
		@jobposts = @tpo.jobposts
		#@colleges = College.all
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
	
	private
		def tpo_params
			params.require(:tpo).permit(:email, :password, :first_name, :last_name, :college)
		end

		def update_tpo_params
			params.require(:tpo).permit(:password, :first_name, :last_name, :job_title)
		end

		def correct_user
			@user = Tpo.find(params[:id])
			redirect_to root_path unless @user == current_user
		end

		def admin_user
			@user = Tpo.find(params[:id])
			redirect_to root_path unless @user.admin
		end

		#def update_all_user(old_email, new_email)
		#	@user = AllUser.find_by(email: old_email)
		#	@user.update_column(:email, new_email)
		#end
end
