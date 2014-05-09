module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_pub(user)
    self.current_user = user
  end
  def signed_in?
    !current_user.nil?
  end


  def current_user=(user)
    @current_user = user
  end


  def current_user
    if params[:remember_token]
      remember_token = params[:remember_token]
    else
      remember_token = User.encrypt(cookies[:remember_token])
    end
    @current_user ||= User.find_by(remember_token:remember_token)
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

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
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

  def pk_id_rules
    require 'securerandom'
    random=SecureRandom.random_number(9999)
    time=Time.now.to_i
    id=(Settings.hospital_code.yuquan+time.to_s+random.to_s).to_i
    return id
  end

end
####################code8.19
