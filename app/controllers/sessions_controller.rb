#encoding:utf-8
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token ,only: [:login_interface]
  layout 'mapp'
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
end