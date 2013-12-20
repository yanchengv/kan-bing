class UsersController < ApplicationController
  before_filter :signed_in_user
  def index
  end
  def show
  end

  def new
  end
  def setting
    @image = '/code/code_image'
    if !current_user['doctor_id'].nil?
      @user1 = User.new
      user = @user1.get_req('find_by_id?doctor_id='+ current_user['doctor_id'].to_s)
      @user = user['data']
    elsif !current_user['patient_id'].nil?
      @user1 = User.new
      user = @user1.get_req('find_by_id?patient_id='+current_user['patient_id'].to_s)
      @user = user['data']
    end
  end
  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end
=begin
  def profile_update
    @email=params[:@user][:email].match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
    puts @email
    p=params[:@user][:sex]
    @sex=true
    if p.to_s=='female'
      @sex=false
    end
    @js={}
    #@users=User.where(username:params[:@user][:username])
    @user0 = User.new
    @users1 = @user0.get_req('findByName?name='+params[:@user][:username])['data']
    @exist=false
    if @users1.length==0
      @exist=true
    elsif @users1.length==1 && @users1['name']==current_user['name']
      @exist=true
    end
    if params[:@user][:username]=='' || params[:@user][:realname]=='' || params[:@user][:email]==''
      @js={:pd => 'null_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    elsif @exist==false
      @js={:pd => 'exist_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    elsif @email.nil?
      @js={:pd => 'email_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    else
      #@user.update_attribute(:username, params[:@user][:username])
      #@user.update_attribute(:realname, params[:@user][:realname])
      #@user.update_attribute(:language, params[:@user][:language])
      #@user.update_attribute(:address, params[:@user][:address])
      #@user.update_attribute(:phone_number, params[:@user][:phone])
      #@user.update_attribute(:email, params[:@user][:email])
      #@user.update_attribute(:birthdate, params[:@user][:birthdate])
      #@user.update_attribute(:sex, @sex)
#todo 调用接口修改数据
      path = ''
      param = {}
      @user0.post_req(path,param)
      cookie[:remember_token] = @user['remember_token']
      sign_in @user
      @js={:pd => 'true'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    end
  end
=end
  def password_update
    puts session[:code]
    current_user_id=current_user['id']
    @js={}
    if params[:@user][:new_password] != params[:@user][:password_confirmation] || params[:@user][:new_password].length<6
      @js={:pd => 'new_false'}
    elsif params[:@user][:code]!=session[:code]
      @js={:pd => 'code_false'}
      respond_to do |format|
        format.html
        format.json  {render :json => @js}
        format.js
      end
    else
      param = {'current_user_id' => current_user_id,'old_password' => params[:@user][:old_password],'new_password' => params[:@user][:new_password]}
      @user = User.new
      @result = @user.post_req('updatePassword',param)
      if @result['success']
        sign_in current_user
        @js={:pd=>'true'}
        respond_to do |format|
          format.html
          format.json  {render json: @js }
          format.js
        end
      else
        @js={:pd=>'old_false'}
        respond_to do |format|
          format.html
          format.json  {render json: @js }
          format.js
        end
      end
    end
    puts 'baekhyun'
    puts @js[:pd]
  end
  private
  def user_params
    params.require(:user).permit(:id, :username,:card_number,:email, :password, :password_confirmation, :patient_id, :doctor_id,:is_doctor, :is_health_admin)
  end
end
