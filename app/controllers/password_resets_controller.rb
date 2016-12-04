class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to new_session_path, :notice => "Email sent with password reset instructions."
    else
      redirect_to new_session_path, :notice => "No user account matches that email"
    end
    
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to new_session_path, :notice => "Password has been reset!"
    else
      render :edit
    end
  end


    private
    def user_params
      return {} if params[:user].blank?
      params.require(:user).permit(:username, :email, :password, :preference_id, :password_confirmation, :role)
    end

end
