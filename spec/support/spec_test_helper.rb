module SpecTestHelper
  def login_admin
    login(:admin)
  end

  def login(user)
    user = User.where(:username => user.to_s).first
    request.session[:user] = user.id
  end

  def current_user
    User.find(request.session[:user])
  end

  def get_user_by_username(username)
    User.where(username: username).first
  end
end
