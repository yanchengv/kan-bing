#encoding:utf-8
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token ,only: [:login_interface]
  require 'multi_json'
  #require 'uri'
  require 'net/http'
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