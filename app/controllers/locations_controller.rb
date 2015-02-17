class LocationsController < ApplicationController
	def index
		@locations = Location.all
	end

	def new
		@location = Location.new
	end

	def create
		location = Location.new(location_params)
		if location.save
			flash[:success] = "Location successfully added"
			redirect_to locations_path
		end
	end

	def edit
		@location = Location.find(params[:id])
	end

	def update
		location = Location.find(params[:id])
		if location.update_attributes(location_params)
			flash[:success] = "Location successfully updated"
			redirect_to locations_path
		end
	end

	def destroy
		location = Location.find(params[:id])
		location.destroy
		flash[:success] = "Location successfully deleted"
		redirect_to locations_path
	end

	private
		def location_params
			params.require(:location).permit(:location, :zone)
		end
end
