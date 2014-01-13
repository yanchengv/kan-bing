module SessionsHelper
  def sign_in(user)
    puts 0
    cookies.permanent[:remember_token] = user['data']['remember_token']
    self.current_user = user['data']
  end
  def signed_in?
    !current_user.nil?
  end


  def current_user=(user)
    @current_user = user
  end


  def current_user
    @user = User.new
    @current_user ||= @user.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end


  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_path, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end


end
####################code8.19
