#encoding:utf-8
class WeixinsController < ApplicationController
  layout 'weixin'
  def login
    @code =  params[:code]
    url = Settings.weixin.sns+"appid="+Settings.weixin.app_id+"&secret="+Settings.weixin.app_secret+"&code="+params[:code]+"&grant_type=authorization_code"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = JSON.parse response.body
    #@access_token = @data["access_token"]
    @open_id = @data["openid"]
    #redirect_to 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx814c2d89e8970870&redirect_uri=http%3A%2F%2F166.111.138.120%3A3000%2Fweixins%2Flogin&response_type=code&scope=snsapi_base&state=123#wechat_redirect' if @open_id.nil?||@open_id==''
    redirect_to WEIXINOAUTH  if @open_id.nil?||@open_id==''
    redirect_to '/weixins/login_already?open_id='+@open_id if WeixinUser.where("openid=?",@open_id).size > 0
    #p @access_token
    #@open_id = '123'
  end
  def login_info
    login_name ||= params[:username]
    password ||= params[:password]
    open_id ||= params[:open_id]
    @flag={}
    if login_name != ''
      user = nil
      if /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.match(login_name)
        user = User.find_by(email:login_name)
      elsif /\d{15}|\d{18}|\d{17}X/.match(login_name)
        user = User.find_by(credential_type_number:login_name)
      elsif /\d{3}-\d{8}|\d{4}-\d{7}|\d{11}/.match(login_name) && login_name.length<=12 && login_name.last.match(/\d/)
        user = User.find_by(mobile_phone:login_name)
      else
        user = User.find_by(name: login_name)
      end

      if params[:password] != ''
        sha1_password = Digest::SHA1.hexdigest(password)
        if user&&(user.authenticate(password)||BCrypt::Password.new(user.password_digest) == sha1_password)&&(!user.doctor.nil? || !user.patient.nil?)
            @wxu = WeixinUser.new
            @wxu.openid = open_id
            @wxu.doctor_id = user.doctor_id
            @wxu.patient_id = user.patient_id
            @flag={success: true, open_id: open_id} if @wxu.save
        else
          @flag={success: false, errorMessage: '用户名或密码错误'}
        end
      else
        @flag={success: false, errorMessage: '密码不能为空'}
      end
    else
      @flag={success: false, errorMessage: '用户名不能为空'}
    end
    render json: @flag
  end
  def login_already
    @open_id = params[:open_id]
  end
  def login_delete
    WeixinUser.where("openid=?",params[:open_id]).delete_all
    redirect_to 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx814c2d89e8970870&redirect_uri=http%3A%2F%2F166.111.138.120%3A3000%2Fweixins%2Flogin&response_type=code&scope=snsapi_base&state=123#wechat_redirect'
  end
end
