# encoding: utf-8
class MailersController < ApplicationController
  layout 'mapp'
  # Include RMagick or ImageScience support:
  #include CarrierWave::RMagick
  require 'socket'
  skip_before_filter :verify_authenticity_token
  skip_before_filter :account
  #输入邮箱页面
  def to_retrieve_pwd_page
    @image = '/code/code_image'
    render template: "users/forget_password"
  end

  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end

  #发送找回密码邮件
  def find_password
    @flag = "false"
    if params[:code]=='' || params[:email]==''
      @flag = 'null'
    elsif params[:code]!=session[:code]
      @flag =  'code_false'
    else
      @email =  params[:email]
      if @email
        #@user = User.find_by_email(@email)
        @user = User.find_by(email:@email)
        if @user
          #生成加密的ID值，存于数据库字段MD5_id中。
          @user.md5id = Digest::MD5.hexdigest(@user.email.to_s+Time.now.to_i.to_s)
          p  @user.md5id
          if @user.update_attributes(md5id: @user.md5id)
            @url = Settings.mimas+"/mailers/update_pwd_page/#{@user.md5id}"
            #@url = "#{request.protocol}www.kanbing365.com/mailers/update_pwd_page/#{@user.md5id}"
            #@url = "#{request.protocol}192.168.1.112:3000/mailers/update_pwd_page/#{@user.md5id}"
            #mail = Mail.new do
            #  from 'yxf_cat_0403@126.com'
            #  to '773198076@qq.com'
            #  subject 'Forgot password!'
            #  body "如果要找回密码，请点击链接：#{@url}"
            #end
            #mail.deliver!
            if UserMailer.find_pwd(@user, @url).deliver
              @flag = "true"
            end
          end
        end
      end
    end
    render :text => "#{@flag}"
  end
  #邮件发送成功的转向页面
  def go_to_show_message
    render "users/show_message"
  end

  #更改密码页面
  def update_pwd_page
    @user = User.find_by(md5id:params[:md5id])
    render "users/reset_pwd", :object => @user
  end

  #重置密码
  def reset_pwd
    @flash = false
    md5id =  params[:user][:md5id]
    if md5id.nil? || md5id==''
      md5id=1
    end
    @user = User.find_by(md5id:md5id)
    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]
    if @user
      if @password == @password_confirmation
        if @user.update_attribute(:password, @password) && @user.update_attribute(:password_confirmation, @password_confirmation) && @user.update_attribute(:md5id, "")
          @flash = false
        else
          @flash = true
          @msg = '密码重置失败！'#t('.The password change failed!')
        end
      else
        @flash = true
        @msg =  '两次密码不一致！'#t('.Two password input inconsistent！')
      end
    else
      @flash = true
      @msg = '密码重置失败！'#t('.The password change failed!')
    end

    if @flash
      render "users/reset_pwd"
    else
      sign_out
      redirect_to root_path
    end
  end



  #   账号激活发送邮箱接口
  def account_active_for_user
    require "base64"
    id=params[:id]
    verify_code=params[:verify_code]
    email=params[:email]

    id=Base64.encode64 id
    verify_code= Base64.encode64 verify_code

    #邮箱内点击进行绑定的url
    url=Settings.mimas+"/sessions/activated_use_email?id=#{id}&verify_code=#{verify_code}"
    @flag= UserMailer.account_active(email,url).deliver

    if @flag
      render json:{success:true}
    else
      render json:{success:false}
    end

  end
end
