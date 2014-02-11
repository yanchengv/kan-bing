module SessionsHelper
  def sign_in(user)
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
    if params[:remember_token]
      cookies[:remember_token] = params[:remember_token]
    end
    @current_user ||= @user.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user

    unless !cookies[:remember_token].nil?
      store_location
      redirect_to root_path, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def store_location
    session[:return_to] = request.url
  end

  def checksignedin
    if current_user.nil?
      flash[:success] = 'please sign in'
      redirect_to root_path
      return false
    else
      return true
    end
  end
end
####################code8.19
