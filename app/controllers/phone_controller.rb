#encoding:utf-8
class PhoneController < ApplicationController
  layout 'kanbing365'
  # require 'iconv'
  def mobile_retrieve_page
    @image = '/code/code_image'
    render :template => 'phone/phone_find_page'
  end

  def check_phone
    @phone_number=params[:phone]
    if @phone_number.nil? || @phone_number == ''
      @phone_number = 1
    end
    @user=User.find_by(mobile_phone:@phone_number)
    if @user.nil?
      render :json => {success:false}
    else
      render :json => {success:true}
    end
  end

  def check_verify_code
    @user = User.find(params[:user_id])
    params[:code]=params[:code]
    if params[:code].nil? || params[:code] ==''
      params[:code]=1
    end
    p params[:code]
    p @user.verification_code
    if @user.verification_code == params[:code]
      render :json => {success:true}
    else
      render :json => {success:false}
    end
  end

  def update_pwd_page
    @user = User.find_by(id:params[:user1][:user_id],verification_code:params[:user1][:code])
    render "phone/reset_pwd_page", :object => @user
  end

  def send_message
      @phone_number=params[:user][:phone]
      if @phone_number.nil? || @phone_number == ''
        @phone_number = 1
      end
      @user=User.find_by(mobile_phone:@phone_number)
      p @user
      if @user.nil?
        flash[:success]='手机号不存在！'
        redirect_to :back
      else
        @pass=""
        6.times do
          @pass=@pass+rand(9).to_s
        end
        input_encode='gbk'
        out_encode='utf8'
        msg=Iconv.new('gb2312','utf8').iconv("恭喜您，注册的健康管理平台审核通过.您的激活验证码为："+@pass+".请及时登陆:www.kanbing365.com网站激活，以防丢失.【绿色医疗】")
        url=URI.escape('http://www.smsadmin.cn/smsmarketing/wwwroot/api/get_send/?uid=viicare&pwd=viicare123&mobile='+mobile_phone+'&msg='+msg)
        @rs=Iconv.new(out_encode,input_encode).iconv(Net::HTTP.get(URI(url)))
        @a=@rs.split(//).first
        if @a.to_i==0
          @user.update_attribute(:verification_code,@pass)
          render template: 'phone/verify_code_page'
        else
          flash[:success]='发送失败！'
          redirect_to :back
        end
      end
  end

  def reset_pwd
    @flash = false
    @user = User.find_by(id:params[:user][:id],verification_code:params[:user][:verification_code])
    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]
    if @user
      if @password == @password_confirmation
        if @user.update_attribute(:password, @password) && @user.update_attribute(:password_confirmation, @password_confirmation) && @user.update_attribute(:verification_code, "")
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
      render "phone/reset_pwd_page"
    else
      sign_out
      redirect_to root_path
    end
  end

end
