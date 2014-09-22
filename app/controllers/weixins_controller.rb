#encoding:utf-8
class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout 'weixin'
  before_filter :get_openid, only: [:login, :user_info, :change_user, :user_message, :patient_register, :shared]
  def login
      redirect_to WEIXINOAUTH  if @open_id.nil?||@open_id==''
      redirect_to '/weixins/login_already?open_id='+@open_id if WeixinUser.where("openid=?",@open_id).size > 0
  end
  def login_info
    login_name ||= params[:username]
    password ||= params[:password]
    open_id ||= params[:open_id]
    code ||= params[:auth_code]
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
          if code==session[:code]
            doc_id = user.doctor_id
            pat_id = user.patient_id
            @wxus = (doc_id.nil?||doc_id=='') ? WeixinUser.where('patient_id=?',pat_id) : WeixinUser.where('doctor_id=?',doc_id)
            @wxus.delete_all
            @wxu = WeixinUser.new
            @wxu.openid = open_id
            @wxu.doctor_id = user.doctor_id
            @wxu.patient_id = user.patient_id
            WeixinUser.where("openid=?",open_id).delete_all
            @flag={success: true, open_id: open_id} if @wxu.save
          else
            @flag={success: false, errorMessage: '验证码错误'}
          end

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
    @wu = WeixinUser.where("openid=?",@open_id).first
    @user = @wu.patient_id==""||@wu.patient_id.nil? ? Doctor.find(@wu.doctor_id) : Patient.find(@wu.patient_id)
  end
  def login_delete
    WeixinUser.where("openid=?",params[:open_id]).delete_all
    redirect_to WEIXINOAUTH
  end
  def change_user
    render template: "weixins/login"
  end
  def user_info
    if @open_id == ''||@open_id.nil?
      redirect_to WEIXININFO
    else
      @wus = WeixinUser.where('openid=?',@open_id)
      if @wus.size>0
        @wu = @wus.first
        @user = @wu.doctor_id.nil?||@wu.doctor_id=='' ? Patient.where('id=?',@wu.patient_id).first : Doctor.where('id=?',@wu.doctor_id).first
      else
        redirect_to WEIXINOAUTH
      end
    end
  end
  def user_message
    if @open_id == ''||@open_id.nil?
      redirect_to WEIXINMESSAGE
    else
      @wus = WeixinUser.where('openid=?',@open_id)
      if @wus.size>0
        @wu = @wus.first
        @notifications = @wu.doctor_id.nil?||@wu.doctor_id=='' ? Notification.where('user_id=?',@wu.patient_id) : Notification.where('user_id=?',@wu.doctor_id)
        @friends_notices,@message_notices,@consultations_notices = [],[],[]
        if !@notifications.nil?
          @notifications.each do |notice|
            if notice.code.to_i==3 || notice.code.to_i==4 || notice.code.to_i==7
              @friends_notices << notice
            elsif notice.code.to_i==8 || notice.code.to_i==9
              @message_notices << notice
            elsif notice.code.to_i==10
              @consultations_notices << notice
            end
          end
        end
      else
        redirect_to WEIXINOAUTH
      end
    end
  end
  def notice_delete
    Notification.where('id=?',params[:id]).first.destroy
    redirect_to WEIXINMESSAGE
  end
  def friend_agree
    @notification = Notification.find(params[:id])
    doctor_id = WeixinUser.find_by_openid(params[:openid]).doctor_id
    if @notification.code == 3
      @dfs = DoctorFriendship.new
      @dfs.doctor1_id = doctor_id
      @dfs.doctor2_id = @notification.content
      @dfs.save
    elsif @notification.code == 4
      @patient = Patient.find(@notification.content)
      if !@patient.doctor_id.nil? && @patient.doctor_id != ''
        @tr = TreatmentRelationship.new
        @tr.patient_id = @notification.content
        @tr.doctor_id = @patient.doctor_id
        @tr.save
      end
      @patient.update_attribute(:doctor_id,doctor_id)
    elsif @notification.code == 7
      @tr = TreatmentRelationship.new
      @tr.patient_id = @notification.content
      @tr.doctor_id = doctor_id
      @tr.save
    end
    @notification.destroy
    redirect_to WEIXINMESSAGE
  end
  def friend_reject
    @notification = Notification.find(params[:id])
    @notification.destroy if !@notification.nil?
    redirect_to WEIXINMESSAGE
  end
  def patient_register

  end
  def register_patient
    if User.where("name=?",params[:name]).size>0
      render json:{success: false, errorMessage: '用户已存在'}
    else
      @patient=Patient.new
      @patient.name = params[:name]
      @patient.mobile_phone=params[:phone]
      @patient.email=params[:email]
      @patient.gender=params[:gender]
      @patient.photo=""
      if @patient.save
        @user = User.new
        @user.name=params[:name]
        @user.patient_id = @patient.id
        @user.password=params[:pass]
        if @user.save
          WeixinUser.where('openid=?',params[:open_id]).delete_all
          @wu=WeixinUser.new
          @wu.openid=params[:open_id]
          @wu.patient_id=@patient.id
          @wu.save
        end
      end
      render json:{success: true, url: WEIXINOAUTH}
    end
  end
  def doctor_register

  end
  def register_doctor
    @doc=Doctor.new
    @doc.name = params[:real_name]
    @doc.mobile_phone=params[:phone]
    @doc.email=params[:email]
    @doc.photo=""
    @doc.gender=params[:gender]
    @doc.hospital_name=params[:hospital]
    @doc.birthday=params[:birthday]
    if @doc.save
      render json:{success: true, url: WEIXINOAUTH}
    end
  end
  def shared
    redirect_to WEIXINOAUTH  if @open_id.nil?||@open_id==''
    @wu = WeixinUser.where("openid=?",@open_id).first
    patient_id = @wu.patient_id
    if patient_id.nil? || patient_id==""
      @patient=false
    else
      @patient=true
      @shareds = Share.where("share_user_id=?",patient_id)
    end
  end
  def article
    @note = Note.find(params[:note_id])
  end
  private
  def get_openid
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
  end
end
