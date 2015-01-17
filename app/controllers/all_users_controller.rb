class AllUsersController < ApplicationController
  def destroy
  	user = AllUser.find(params[:id])
  	user_email = user.email
	if Tpo.find_by(email: user_email)
		Tpo.find_by(email: user_email).destroy
	elsif Student.find_by(email: user_email)
		Student.find_by(email: user_email).destroy
	end
	AllUser.find_by(email: user_email).destroy
	flash[:success] = "User deleted"
	redirect_to all_users_url
  end

  def index
  	redirect_to current_user
  end
end
