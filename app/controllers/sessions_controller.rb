class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_user_path(user), :notice => "Logged in!"
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_url, :notice => "Logged out!"
  end

end