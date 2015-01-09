class TposController < ApplicationController

	def new
		@tpo = Tpo.new
	end

	def show
		@tpo = Tpo.find(params[:id])
		#@colleges = College.all
	end

	def create
		@tpo = Tpo.new(tpo_params)
		if @tpo.save
			flash[:success] = "Welcome to simplifica"
			redirect_to @tpo
		else
			render 'new'
		end
	end

	private
		def tpo_params
			params.require(:tpo).permit(:email, :password, :name, :college)
		end
end
