#encoding:utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user,except:[:username_verification,:register_user,:sign_up]
  skip_before_filter :verify_authenticity_token ,only: [:register_user,:sign_up]
  def index
  end
  def show
  end

  def new
  end
  def setting
    @image = '/code/code_image'
    @user = nil
    @photo=''
    if !current_user.doctor_id.nil?
      @user = Doctor.find(current_user.doctor_id)
    elsif !current_user.patient_id.nil?
      @user = Patient.find(current_user.patient_id)
    end
    if !@user.photo.nil? && @user.photo!=''
      @photo = Settings.pic+@user.photo
    end

  end
  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end

  def profile_update
    user=params['@user']
    username=user['username']
    name=user['name']
    email=user['email']
    mobile_phone=user['mobile_phone']
    language=user['language']
    birthday=user['birthday']
    gender=user['gender']
    p gender
    address=user['address']
    current_user.update_attributes(name:username,email:email,mobile_phone:mobile_phone)
    if !current_user.doctor_id.nil?
      expertise=user['expertise']
      introduction=user['introduction']
      current_user.doctor.update_attributes(name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,expertise:expertise,introduction:introduction)
    else
      current_user.patient.update_attributes(name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address)
    end

    @image = '/code/code_image'
    @user = nil
    @photo=''
    if !current_user.doctor_id.nil?
      @user = Doctor.find(current_user.doctor_id)
    elsif !current_user.patient_id.nil?
      @user = Patient.find(current_user.patient_id)
    end
    if !@user.photo.nil? && @user.photo!=''
      @photo = Settings.pic+@user.photo
    end
    render partial: 'users/setting_profile'

  end



  def password_update
    #puts session[:code]
    #@js={}
    #if params[:@user][:new_password] != params[:@user][:password_confirmation] || params[:@user][:new_password].length<6
    #  @js={:pd => 'new_false'}
    #elsif params[:@user][:code]!=session[:code]
    #  @js={:pd => 'code_false'}
    #  respond_to do |format|
    #    format.html
    #    format.json  {render :json => @js}
    #    format.js
    #  end
    #else
    #  if current_user.authenticate(params[:@user][:old_password]) == false
    #    @js={:pd=>'old_false'}
    #    respond_to do |format|
    #      format.html
    #      format.json  {render json: @js }
    #      format.js
    #    end
    #  else
        current_user.update_attribute(:password, params[:@user][:new_password])
        sign_in current_user
    #    @js={:pd=>'true'}
    #    respond_to do |format|
    #      format.html
    #      format.json  {render json: @js }
    #      format.js
    #    end
    #  end
    #end
    #puts 'baekhyun'
    #puts @js[:pd]
    flash[:success]='密码修改成功！'
    redirect_to root_path
  end

  def find_by_name
    @user = User.new
    @doctors = Doctor.find_by_name(params[:@user][:name])
    if @doctors.length == 1
      redirect_to '/doctors/doctorpage/' + @doctors.first.id.to_s
    else
      @doctor_users = @doctors.paginate(:per_page =>8,:page => params[:page])
      render :template => 'users/search_doctors'
    end
  end


  #院内同步时，验证用户名是否已存在
  def username_verification
    username=params[:username]
    @user=User.find_by_name(username)
    if @user
      render json:{success:false,content:'此用户名已存在'}
    else

      render json:{success:true,content:'此用户名可以使用'}
    end

  end

  #修改个人信息用户名验证
  def check_username
    username=params[:username]
    @user=User.find_by_name(username)
    if @user&&current_user.name!=username
      render json:{success:false,content:'此用户名已存在'}
    else
      render json:{success:true,content:'此用户名可以使用'}
    end
  end
  def check_email
    email=params[:email]
    @user=User.where('email=?',email)
    if !@user.empty? && current_user.email!=email
      render json:{success:false,content:'此邮箱已注册'}
    else
      render json:{success:true,content:'此邮箱可以使用'}
    end
  end
  def check_phone
    mobile_phone=params[:phone]
    @user=User.where('phone=?',mobile_phone)
    if @user && current_user.mobile_phone!=mobile_phone
      render json:{success:false,content:'此电话已占用'}
    else
      render json:{success:true,content:'电话可以使用'}
    end
  end

   def register_user
     username=params[:username]
     email=params[:email]
     mobile_phone=params[:phone]
     @user1=[]
     @user2=[]
     @user3=[]
     user1=true
     user2=true
     user3=true
     if !username.nil?&&username!=''
       @user1=User.where('name=?',username)
       if !@user1.empty?
         user1=false
       end
     end
     if !email.nil?&&email!=''
       @user2=User.where('email=?',email)
       if !@user2.empty?
         user2=false
       end
     end
     if !mobile_phone.nil?&&mobile_phone!=''
       @user3=User.where('mobile_phone=?',mobile_phone)
       if !@user3.empty?
         user3=false
       end
     end
     if  @user1.empty?&&@user2.empty?&&@user3.empty?
       render json:{success:true,username:user1,email:user2,mobile_phone:user3}
      else
        render json:{success:false,username:user1,email:user2,mobile_phone:user3}
      end

   end

  def sign_up
    if !params[:username].nil?&&params[:username]!=''&&!params[:password].nil?&&params[:password]!=''&&((!params[:doctor_id].nil?&&params[:doctor_id]!=''&&(params[:patient_id].nil?||params[:patient_id]==''))||(!params[:patient_id].nil?&&params[:patient_id]!=''&&(params[:doctor_id].nil?||params[:doctor_id]=='')))
      username=params[:username]
      email=params[:email]
      mobile_phone=params[:mobile_phone]
      doctor_id = params[:doctor_id]
      patient_id = params[:patient_id]
      password = params[:password]
      password_confirmation = params[:password_confirmation]
      credential_type_number = params[:credential_type_number]
      @user1=[]
      @user2=[]
      @user3=[]
      msg=''
      #if !username.nil?&&username!=''
        @user1=User.where('name=?',username)
        if !@user1.empty?
          msg='用户名重复！'
        end
      #end
      if !email.nil?&&email!=''
        @user2=User.where('email=?',email)
        if !@user2.empty?
          msg=msg+'邮箱重复！'
        end
      end
      if !mobile_phone.nil?&&mobile_phone!=''
        @user3=User.where('mobile_phone=?',mobile_phone)
        if !@user3.empty?
          msg=msg+'手机号重复！'
        end
      end
      if  @user1.empty?&&@user2.empty?&&@user3.empty?
        @user = User.new(name:username,email:email,mobile_phone:mobile_phone,credential_type_number:credential_type_number,password:password,password_confirmation:password_confirmation,doctor_id:doctor_id,patient_id:patient_id)
        if @user.save
          render json:{success:true,data:@user}
        else
          render json:{success:false,data:'注册失败！'}
        end
      else
        render json:{success:false,data:msg}
      end
    else
      render json:{success:false,data:'用户名和密码必填，医生id和患者id只能且必须填写一个！'}
    end

  end

  def check_old_pwd
     if current_user.authenticate(params[:old_password])
       render json:{success:true,content:'原密码正确！'}
     else
       render json:{success:false,content:'原密码错误！'}
     end
  end

  def check_code
    if params[:code]==session[:code]
      render json:{success:true,content:' 验证码正确！'}
    else
      render json:{success:false,content:'验证码错误！'}
    end
  end
  private
  def user_params
    params.require(:user).permit(:id, :username,:card_number,:email, :password, :password_confirmation, :patient_id, :doctor_id,:is_doctor, :is_health_admin)
  end
end