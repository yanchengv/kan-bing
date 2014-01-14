module SessionsHelper
  def sign_in(user)
    puts 0
    cookies.permanent[:remember_token] = user['data']['remember_token']
    self.current_user = user['data']
  end
  def signed_in?
   if !cookies[:remember_token].nil?
    !current_user.nil?
    else
      false
     end
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

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


end
####################code8.19
