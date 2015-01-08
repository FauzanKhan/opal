class TposController < ApplicationController

	def new
		@tpo = Tpo.new
	end

	def create
		@tpo = Tpo.new(params.require(:tpo).permit(:email, :password, :name, :college))
		@tpo.save
		redirect_to @tpo
	end
end
