class JobpostsController < ApplicationController
	#before_action :logged_in_user, [only: :new, :create, :destroy, :edit]
	
	def new
		@tpo = current_user
		@jobpost = Jobpost.new
	end

	def create
		@tpo = current_user
		@jobpost = current_user.jobposts.build(jobpost_params)
		if @jobpost.save
			flash[:success] = "Job Posted Successfully"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def show

	end

	def edit

	end

	def update

	end

	def destroy

	end

	private
		def jobpost_params
			params.require(:jobpost).permit(:company, :position, :req_percentage, :required_brach, :other_requirements, :job_profile, :location, :venue )
		end

end
