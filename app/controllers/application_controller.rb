class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception


  #allows the view to use this method
	helper_method :current_user, :searchableHealthLabels, :searchableDietLabels

	private

	#get current user
	def current_user
	  if session[:user_id]
	  	begin
	  		User.find(session[:user_id])
	  	rescue ActiveRecord::RecordNotFound
	  		session[:user_id]=nil
	  		nil
	  	end

	  end
	end

	def searchableHealthLabels
		[1,7,10,11,12]
	end

	def searchableDietLabels
		[1,3,4,5]
	end

end
