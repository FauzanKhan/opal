class AccountActivationsController < ApplicationController
	def edit
    user = Tpo.find_by(email: params[:email]) || Student.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      if user.user_type == 2
        flash[:success] = "Account activated! Please Take 2 minutes to complete your profile as your profile works as your CV on simplifiaca"
        redirect_to edit_student_path(user)
      else
        flash[:success] = "Account activated!" 
        redirect_to user
      end
      if(user.user_type == 1)
        user.update_college_table
        user.update_column(:college_id, College.find_by(college_name: user.college).id)
      end
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
