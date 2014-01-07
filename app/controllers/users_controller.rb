#encoding:utf-8
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
    if current_user
      @user1 = User.new
      user = @user1.get_req('users/find_by_id?user_id='+current_user['id'].to_s)['data']
      if !user['doctor'].nil?
        @user = user['doctor']
      elsif !user['patient'].nil?
        @user = user['patient']
      end
      @photos = user['photos']
    end
  end
  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end

  def profile_update
    @email=params[:@user][:email].match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
    p=params[:@user][:sex]
    @sex='男'
    if p.to_s=='female'
      @sex='女'
    end
    @js={}
    #@users=User.where(username:params[:@user][:username])
    @user0 = User.new
    @users1 = @user0.get_req('users/find_by_name?name='+params[:@user][:username])['data']
    @exist=false
    puts current_user['name']
    if @users1.nil?
      puts 'baekhyun'
      @exist=true
    elsif !@users1.nil? && @users1['name']==current_user['name']
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
      path = 'users/update_profile?user_id='+current_user['id'].to_s+'&realname='+ params[:@user][:realname] + '&address=' + params[:@user][:address]+'&phone='+params[:@user][:phone]+'&email='+params[:@user][:email]+'&birtday='+ params[:@user][:birthdate]+'&gender='+@sex
      #path1 = 'users/update_profile'
      param = {'user_id' => current_user['id'],'username' => params[:@user][:username],'realname' => params[:@user][:realname],'address' => params[:@user][:address],'phone' => params[:@user][:phone],'email' => params[:@user][:email],'birthday' => params[:@user][:birthdate],'gender' => @sex}
      @user0.put_req(path,param)
      #@user0.post_req(path1,param)
      @js={:pd => 'true'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    end
  end

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
      @result = @user.put_req('users/updatePassword?current_user_id='+current_user_id.to_s+'&old_password='+params[:@user][:old_password]+'&new_password='+params[:@user][:new_password],param)
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
