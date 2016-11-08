class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #allows the view to use this method
	helper_method :current_user

	private

	#get current user
	def current_user
	  if session[:user_id]
	  	begin 
	  		User.find(session[:user_id])
	  	rescue ActiveRecord::RecordNotFound
	  		nil
	  	end
	  end
	end
	
end
