#encoding:utf-8
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token ,only: [:login_interface,:login_center,:destroy]
  before_filter :signed_in_user, :only => [:change_login_user]
  layout 'kanbing365'
  require 'multi_json'
  #require 'uri'
  require 'net/http'
  def register_page
    render 'sessions/register_page'
  end

  def sign_up
    user_type=params[:session][:user_type]
    username=params[:session][:username]
    email=params[:session][:email]
    mobile_phone=params[:session][:mobile_phone]
    password=params[:session][:password]
    if user_type == "1"
      @doctor = Doctor.new(name:username,email:email,mobile_phone:mobile_phone,birthday:'1900-01-01')
      if @doctor.save
        @user = User.new(name:username,doctor_id:@doctor.id,email:email,mobile_phone:mobile_phone,password:password)
        if @user.save
          sign_in @user
          #redirect_to action:'setting',controller:'users'
          respond_to do |format|
            format.html
            #format.json { render json: @flag }
            format.js
          end
        end
      end
    else
      @patient = Patient.new(name:username,email:email,mobile_phone:mobile_phone)
      if @patient.save
        @user = User.new(name:username,patient_id:@patient.id,email:email,mobile_phone:mobile_phone,password:password)
        if @user.save
          sign_in @user
          respond_to do |format|
            format.html
            #format.json { render json: @flag }
            format.js
          end
        end
      end
    end
  end

  def check_email
    @user2 = User.find_by(email:params[:email])
    if !@user2.nil?
      p @user2.name
      render :json => {success:false,msg:'此用邮箱已注册！'}
    else
      p 'baek'
      render :json => {success:true,msg:'此用邮箱可用！'}
    end
  end
  def check_username
    @user1 = User.find_by(name:params[:username])
    if !@user1.nil?
      render :json => {success:false,msg:'此用户名已被占用！'}
    else
      render :json => {success:true,msg:'此用户名可以使用！'}
    end
  end
  def create
    login_name = params[:session][:username]
    password = params[:session][:password]
    @flag={}
    if login_name != ''
      user = nil
      if /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.match(login_name)
        puts 'email'
         user = User.find_by(email:login_name)
      elsif  /\d{15}|\d{18}|\d{17}X/.match(login_name)
        puts 'number'
        user = User.find_by(credential_type_number:login_name)
      elsif /\d{3}-\d{8}|\d{4}-\d{7}|\d{11}/.match(login_name) && login_name.length<=12 && login_name.last.match(/\d/)
        puts 'phone'
        user = User.find_by(mobile_phone:login_name)
      else
        puts 'name'
        user = User.find_by(name: login_name)
      end
      if params[:password] != ''
        sha1_password = Digest::SHA1.hexdigest(password)
        if user&&(user.authenticate(password)||BCrypt::Password.new(user.password_digest) == sha1_password)&&(!user.doctor.nil? || !user.patient.nil?)
          if !user.patient_id.nil?
            @doctor = Doctor.where(:patient_id => user.patient_id).first
            if @doctor
              user.patient_id = ''
              user.doctor_id = @doctor.id
            end
          end
          sign_in user
          @flag={:flag => 'true'}
          respond_to do |format|
            format.html
            format.json { render json: @flag }
            format.js
          end
        else
          @flag={:flag => 'false'}
          respond_to do |format|
            format.html
            format.json { render json: @flag }
            format.js
          end
        end
      else
        @flag={:flag => 'pwd_blank'}
        respond_to do |format|
          format.html
          format.json { render json: @flag }
          format.js
          end
      end
    else
      @flag={:flag => 'name_blank'}
      respond_to do |format|
        format.html
        format.json { render json: @flag }
        format.js
      end
    end
  end



  def login_center
    login_name = params[:session][:username]
    password = params[:session][:password]
    @flag={}
    if login_name != ''
      user = nil
      if /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.match(login_name)
        puts 'email'
        user = User.find_by(email:login_name)
      elsif  /\d{15}|\d{18}|\d{17}X/.match(login_name)
        user = User.find_by(credential_type_number:login_name)
      elsif /\d{3}-\d{8}|\d{4}-\d{7}|\d{11}/.match(login_name) && login_name.length<=12 && login_name.last.match(/\d/)
        user = User.find_by(mobile_phone:login_name)
      else
        user = User.find_by(name: login_name)
      end
      if params[:password] != ''
        sha1_password = Digest::SHA1.hexdigest(password)
        if user&&(user.authenticate(password)||BCrypt::Password.new(user.password_digest) == sha1_password)&&(!user.doctor.nil? || !user.patient.nil?)
          if !user.patient_id.nil?
            @doctor = Doctor.where(:patient_id => user.patient_id).first
            if @doctor
              user.patient_id = ''
              user.doctor_id = @doctor.id
            end
          end
          sign_in user
          @flag={:flag => 'true'}
          render json: @flag
        else
          @flag={:flag => 'false'}
          render json: @flag
        end
      else
        @flag={:flag => 'pwd_blank'}
        render json: @flag
      end
    else
      @flag={:flag => 'name_blank'}
      render json: @flag
    end
  end
  def login_interface
    login_name = params[:username]
    password = params[:password]
    if login_name != ''
      user = nil
      if /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.match(login_name)
        puts 'email'
        user = User.find_by(email:login_name)
      elsif  /\d{15}|\d{18}|\d{17}X/.match(login_name)
        puts 'number'
        user = User.find_by(credential_type_number:login_name)
      elsif /\d{3}-\d{8}|\d{4}-\d{7}|\d{11}/.match(login_name) && login_name.length<=12 && login_name.last.match(/\d/)
        puts 'phone'
        user = User.find_by(mobile_phone:login_name)
      else
        puts 'name'
        user = User.find_by(name: login_name)
      end
      if params[:password] != ''
        sha1_password = Digest::SHA1.hexdigest(password)
        if user&&(user.authenticate(password)||BCrypt::Password.new(user.password_digest) == sha1_password)&&(!user.doctor.nil? || !user.patient.nil?)
          remember_token = User.new_remember_token
          p remember_token
          #cookies.permanent[:remember_token] = remember_token
          user.update_attribute(:remember_token, User.encrypt(remember_token))
          #sign_pub user
          #sign_in user
          #doctor = user.doctor
          #patient =  user.patient
          #json = {success:true,data:user,doctor:doctor,patient:patient,token:remember_token}
          json = {success:true,data:user,token:remember_token}
          render :json => json
        else
          json = {success:false,data:'false'}
          render :json => json
        end
      else
        json = {success:false,data:'pwd_blank'}
        render :json => json
      end
    else
      json = {success:false,data:'name_blank'}
      render :json => json
    end
  end

  def destroy
     sign_out
    redirect_to root_path
  end

  def activated_user
    render template: 'doctors/activated_user'
  end

  def check_phone
    mobile_phone = params[:phone]
    @doctor = Doctor.find_by(mobile_phone:mobile_phone)
    @patient = Patient.find_by(mobile_phone:mobile_phone)
    if !@doctor.nil? &&@patient.nil?
      if @doctor.is_activated==1
        render json:{success:false,msg:'该账号已激活！'}
      else
        render json:{success:true,msg:'手机号正确！'}
      end
    elsif !@patient.nil? &&@doctor.nil?
      if @patient.is_activated==1
        render json:{success:false,msg:'该账号已激活！'}
      else
        render json:{success:true,msg:'手机号正确！'}
      end
    elsif !@patient.nil? && !@doctor.nil?
      render json:{success:false,msg:'医生患者手机号重复！'}
    else
      render json:{success:false,msg:'不存在该手机号！'}
    end
  end

  def check_code
    mobile_phone = params[:phone]
    verify_code = params[:code]
    @doctor = Doctor.find_by(mobile_phone:mobile_phone)
    @patient = Patient.find_by(mobile_phone:mobile_phone)
    if !@doctor.nil? &&@patient.nil?
      if @doctor.verify_code == verify_code.to_s
        render json:{success:true,msg:'验证码正确！'}
      else
        render json:{success:false,msg:'验证码错误！'}
      end
    elsif !@patient.nil? &&@doctor.nil?
      if @patient.verify_code == verify_code.to_s
        render json:{success:true,msg:'验证码正确！'}
      else
        render json:{success:false,msg:'验证码错误！'}
      end
    elsif !@patient.nil? && !@doctor.nil?
      render json:{success:false,msg:'医生患者手机号重复！'}
    else
      render json:{success:false,msg:'不存在该手机号！'}
    end
  end



  # 手机验证码激活
  def activated
    mobile_phone = params[:session][:mobile_phone]
    verify_code = params[:session][:verify_code]
    @doctor = Doctor.find_by(mobile_phone:mobile_phone,verify_code:verify_code,is_activated:0)
    @patient=Patient.find_by(mobile_phone:mobile_phone,verify_code:verify_code,is_activated:0)
    if !@doctor.nil? &&@patient.nil?
      render template: 'sessions/phone_init_user'
    elsif !@patient.nil? &&@doctor.nil?
      render template: 'sessions/phone_init_user'
    else
      redirect_to :back
    end
  end

  # 手机验证码用户名输入方法
  def init_user
    username=params[:session][:username]
    password=params[:session][:password]
    doctor_id=params[:session][:doctor_id]
    patient_id=params[:session][:patient_id]
    @doctor=Doctor.find_by(id:doctor_id)
    @patient=Patient.find_by(id:patient_id)
    if  @doctor
      @user = User.new(name:username,password:password,mobile_phone:@doctor.mobile_phone,email:@doctor.email,doctor_id:@doctor.id,credential_type_number:@doctor.credential_type_number)
      if @user.save
        @doctor.is_activated=1
        @doctor.save
        sign_in @user
        render template: 'sessions/phone_activated_success'
      else
        redirect_to :back
      end
    else
      @user = User.new(name:username,password:password,mobile_phone:@patient.mobile_phone,email:@patient.email,patient_id:@patient.id,credential_type_number:@patient.credential_type_number)
      if @user.save
        @patient.is_activated=1
        @patient.save
        sign_in @user
        render template: 'sessions/phone_activated_success'
      else
        redirect_to :back
      end
    end

  end

  # 邮箱验证码激活
  def init_user2
    username=params[:session][:username]
    password=params[:session][:password]
    doctor_id=params[:session][:doctor_id]
    patient_id=params[:session][:patient_id]
    @doctor=Doctor.find_by(id:doctor_id)
    @patient=Patient.find_by(id:patient_id)
    if  @doctor
      @user = User.new(name:username,password:password,mobile_phone:@doctor.mobile_phone,email:@doctor.email,doctor_id:@doctor.id,credential_type_number:@doctor.credential_type_number)
      if @user.save
        @doctor.is_activated=1
        @doctor.save
        sign_in @user
        render template: 'sessions/email_activated_success'
      else
        redirect_to :back
      end
    else
      @user = User.new(name:username,password:password,mobile_phone:@patient.mobile_phone,email:@patient.email,patient_id:@patient.id,credential_type_number:@patient.credential_type_number)
      if @user.save
        @patient.is_activated=1
        @patient.save
        sign_in @user
        render template: 'sessions/email_activated_success'
      else
        redirect_to :back
      end
    end
  end



  # 邮箱链接点击进入的方法
  def email_activated
    require 'base64'
    flash[:success]=nil
    doctor_id = params[:id]
    doctor_id = Base64.decode64 doctor_id
    verify_code = params[:verify_code]
    verify_code = Base64.decode64 verify_code

    @doctor = Doctor.find_by(id:doctor_id,verify_code:verify_code,is_activated:0)
    @patient=Patient.find_by(id:doctor_id,verify_code:verify_code,is_activated:0)
    if !@doctor.nil? &&@patient.nil?
      render template: 'sessions/email_init_user'
    elsif !@patient.nil? &&@doctor.nil?
      render template: 'sessions/email_init_user'
    else
      flash[:success]='该账号已激活！或该链接已失效！'
        redirect_to '/'
    end
  end



  def find_pwd_type
    render template: 'users/find_back_way'
  end

  #更改登录用户
  def change_login_user
    if params[:str] == 'patient'
      if !current_user.doctor_id.nil? && current_user.doctor_id != ''
        @doctor = current_user.doctor
      else
        if !current_user.patient_id.nil? && current_user.patient_id != ''
          @doctor = Doctor.where(:patient_id => current_user.patient_id).first
        end
      end

      if @doctor 
        if !@doctor.patient_id.nil? && @doctor.patient_id != ''

        else
          @patient = Patient.new(:name => @doctor.name, :credential_type => @doctor.credential_type, :credential_type_number => @doctor.credential_type_number, :gender => @doctor.gender,
                                    :birthday => @doctor.birthday, :birthplace => @doctor.birthplace, :province_id => @doctor.province_id, :city_id => @doctor.city_id, :hospital_id => @doctor.hospital_id,
                                    :department_id => @doctor.department_id, :address => @doctor.address, :nationality => @doctor.nationality, :citizenship => @doctor.citizenship, :photo => @doctor.photo,
                                    :marriage => @doctor.marriage, :mobile_phone => @doctor.mobile_phone, :home_phone => @doctor.home_phone, :home_address => @doctor.home_address, :contact => @doctor.contact,
                                    :contact_phone => @doctor.contact_phone, :home_postcode => @doctor.home_postcode, :email => @doctor.email, :introduction => @doctor.introduction, :verify_code => @doctor.verify_code,
                                    :is_checked => @doctor.is_checked, :is_activated => @doctor.is_activated, :is_public => @doctor.is_public, :spell_code => @doctor.spell_code, :province => @doctor.province_name)
          if @patient.save
            @doctor.update_attributes(:patient_id => @patient.id)
          end
        end
        current_user.patient_id = @doctor.patient_id
        current_user.doctor_id = ''
        sign_in current_user
      end
    elsif params[:str] == 'doctor'
      @doctor = Doctor.where(:patient_id => current_user.patient_id).first
      if @doctor && !@doctor.id.nil?
          current_user.doctor_id = @doctor.id
          current_user.patient_id = ''
          sign_in current_user
      end
    else
      puts "除了医生和患者的其它身份"
    end
    redirect_to '/home'
  end

end