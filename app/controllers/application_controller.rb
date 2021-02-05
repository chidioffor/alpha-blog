class ApplicationController < ActionController::Base

	helper_method :current_user, :logged_in?

	def current_user
		# if session id exists accorting to create method in session controller
		# then find the user in model and return user object as @current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user #return a true/false of current_user method above
	end

	def require_user
		if !logged_in? 
			flash[:alert] = "You must be logged in to perform that action"
			redirect_to login_path
		end
	end
	
end
