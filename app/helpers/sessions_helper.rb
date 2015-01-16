module SessionsHelper
	
	def log_in(user)
		session[:user_id] = user.id
    session[:user_email] = user.email
	end

	def remember(user)
    	user.remember
    	cookies.permanent.signed[:user_id] = user.id
    	cookies.permanent[:remember_token] = user.remember_token
      cookies.permanent[:user_email] = user.email
  	end

  	def forget(user)
  		user.forget
  		cookies.delete(:user_id)
  		cookies.delete(:remember_token)
      cookies.delete(:user_email)
  	end

	def current_user

		if (user_id = session[:user_id])
        user_email = session[:user_email]
  			@current_user ||= Tpo.find_by(id: user_id, email: user_email) || Student.find_by(id: user_id, email: user_email)

  		elsif (user_id = cookies.signed[:user_id])
        user_email = cookies[:user_email]
  			user = Tpo.find_by(id: user_id, email: user_email) || Student.find_by(id: user_id, email: user_email)
  			if user && user.authenticated?(cookies[:remember_token])
  				log_in user
  				@current_user = user
  			end

  		end

	end

	def logged_in?
    	!current_user.nil?
  	end

  	def log_out
      forget(current_user)
  		session.delete(:user_id)
  		@current_user = nil
  	end

    #implementing friendly forwarding
  
    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    def store_url
      session[:forwarding_url] = request.url if request.get?
    end

end
