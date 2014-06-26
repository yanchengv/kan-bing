#encoding:utf-8
class AppSessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'multi_json'
  require 'net/http'
  require 'socket'

  def sign_up_app
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
  def login_app
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
          doctor = user.doctor
          patient =  user.patient
          json = {success:true,data:user,doctor:doctor,patient:patient}
          render :json => json
        else
          json = {success:false,data:'用户名或密码错误'}
          render :json => json
        end
      else
        json = {success:false,data:'密码不能为空'}
        render :json => json
      end
    else
      json = {success:false,data:'用户名不能为空'}
      render :json => json
    end
  end

  def check_signed_in_app
    if app_checksignedin
      render json:{success:true,data:app_user}
    else
      render json:{success:false,data:' 你尚未登录，请登录后再进行操作！'}
    end
  end

  def send_email_app
    if params[:email]==''
      render json:{success:true,data:'邮箱不能为空！'}
    else
      @email =  params[:email]
      if @email
        @user = User.find_by(email:@email)
        if @user
          #生成加密的ID值，存于数据库字段MD5_id中。
          @user.md5id = Digest::MD5.hexdigest(@user.email.to_s+Time.now.to_i.to_s)
          if @user.update_attributes(md5id: @user.md5id)
            @url = "#{request.protocol}www.kanbing365.com/mailers/update_pwd_page/#{@user.md5id}"
            if UserMailer.find_pwd(@user, @url).deliver
              render json:{success:true,data:'邮件发送成功！'}
            else
              render json:{success:false,data:'邮件发送失败！'}
            end
          end
        else
          render json:{success:false,data:'邮箱不正确！'}
        end
      end
    end
  end

  def find_by_md5id_app
    @user = User.find_by(md5id:params[:md5id])
    if @user
      render json:{success:true,data:@user}
    else
      render json:{success:false,data:'md5id无效！'}
    end
  end

  def reset_password_app
    @user = User.find_by(md5id:params[:md5id])
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    p @password
    p @password_confirmation
    if @user
      if @password == @password_confirmation
        if @user.update_attribute(:password, @password) && @user.update_attribute(:password_confirmation, @password_confirmation) && @user.update_attribute(:md5id, "")
          render json:{success:true,data:'密码重置成功！'}
        else
          render json:{success:false,data: '密码重置失败！'}
        end
      else
        render json:{success:false,data: '两次密码不一致！'}
      end
    else
      render json:{success:false,data: 'md5id无效！'}
    end
  end

end