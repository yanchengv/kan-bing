#encoding:utf-8
class WeixinPatientController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout 'weixin'
  before_filter :is_login, only: [:login,:my_doctor,:health_record, :user_message,:shared,:show_manage_account]
  #登陆判断
  def login

  end
  # 执行login获取 @open_id
  def login_form
    @open_id = params[:open_id]
  end
  #点击确定登陆后执行提交
  def submit_login
    mobile_phone ||= params[:mobile_phone]
    open_id||=params[:open_id]
    verify_code=params[:verify_code]
    @patient=Patient.where(mobile_phone:mobile_phone).first


      if  !@patient.nil?
        #判断此患者是否是一个医生用户
        @doctor=Doctor.where(patient_id:@patient.id ).first
        if  !@doctor.nil?
          @user=User.where(doctor_id:@doctor.id).first
        else
          @user=User.where(patient_id:@patient.id).first
        end

      if !@user.nil?
       if  verify_code==session[:"#{mobile_phone}"].to_s
      @wxus = WeixinUser.where('patient_id=? or openid=? ',@patient.id,open_id)
      # if !@wxus.empty?
      #   @wxu = WeixinUser.new
      #   @wxu.sendByOpenId(@wxus.first.openid,"由于您的kanbing365账号已经在其它微信账号登录,您已安全退出.如不是本人操作，请重新登录")
      #
      # end
      @is_succ=@wxus.delete_all
      @weixin_user=WeixinUser.new(openid:open_id,patient_id:@patient.id)
       if  @weixin_user.save
         @flag={success: true, open_id: open_id,content:'登陆成功！'}
         @weixin_user.send_message_to_weixin('patient',@patient.id,"登陆成功!")

       end
       else
         @flag={success: false, content: '验证码错误！'}
       end
      else
        @flag={success: false, content: '此手机尚未开通！'}
      end
    else
      @flag={success: false, content: '此手机尚未注册！'}
    end
     render json:@flag
  end

  def show_patient_register
      @open_id=get_openid
  end

   # 展现账户管理
   def  show_manage_account
       @patient=@patient

   end
  # 保存账户管理的修改
  def save_manage_account
    # {"name"=>"张小军", "mobile_phone"=>"15810159353", "credential_type_number"=>"410726198912203834", "birthday"=>"2015-03-23", "gender"=>"男", "patient_id"=>"113932081081001"}
    param={}
    patient_id=params[:patient_id]
    @patient=Patient.where(id:patient_id).first;
    param[:name]=params[:name]
    param[:mobile_phone]=params[:mobile_phone]
    param[:credential_type_number]=params[:credential_type_number]
    param[:birthday]=params[:birthday]
    param[:gender]=params[:gender]

    @patient_m=Patient.where(mobile_phone:params[:mobile_phone]).first
    @patient_c=Patient.where(credential_type_number:params[:credential_type_number]).first
    if  @patient_m.nil?
      if @patient_m.id!=@patient.id

        render json:{flag:false,content:'手机号已存在'}
      end

    end

    if  @patient_c.nil?
      if @patient_c.id!=@patient.id
        render json:{flag:false,content:'身份证号已存在'}
      end
    end

    @patient.update_attributes(param)
    @user=User.where(patient_id:@patient.id).first
    if !@user.nil?
      if  param[:mobile_phone]!=@user.mobile_phone
        @user.update_attributes(mobile_phone:param[:mobile_phone])
      end
      if  param[:credential_type_number]!=@user.credential_type_number
      @user.update_attributes(credential_type_number:param[:credential_type_number])
      end
    end
    render json:{flag:true,content:'修改成功'}
  end

  # 检验注册的用户手机号和验证码是否合法
  def check_phone_code

    mobile_phone=params[:mobile_phone]
    verify_code=params[:verify_code]
    @user=User.where("mobile_phone=?",mobile_phone).first
    if  !@user.nil?
      render json:{success: false,content:'此手机号码已经注册过了'}
    elsif verify_code!=session[:"#{mobile_phone}"].to_s
      render json:{success: false,content:'验证码不正确'}
    else
      render json:{success: true,content:'验证通过'}
    end



  end
  def create_patient_register
    # open_id=get_openid
    open_id=params[:open_id]
    mobile_phone=params[:mobile_phone]
    password=params[:password]
    @patient=Patient.where("mobile_phone=?",mobile_phone).first
    # 使用手机号判断是否存患者
    if  !@patient.nil?
       @user=User.where(patient_id: @patient.id)
       # 如果患者已存在，判断是否已成为公网用户
      if !@user.empty?
        render json:{success: false, content: '手机号已存在,并且已经成为公网用户'}
      else

        @user = User.new()
        @user.name=mobile_phone
        @user.mobile_phone=mobile_phone
        @user.patient_id = @patient.id
        @user.password=password
        if @user.save
          WeixinUser.where('openid=?',params[:open_id]).delete_all
          @wu=WeixinUser.new
          @wu.openid=params[:open_id]
          @wu.patient_id=@patient.id
          @wu.save
          @wu.sendByOpenId(params[:open_id],"注册成功并已成功登陆")
        end
        render json:{success: true}
      end
    else
      @patient=Patient.new()
      @patient.name = mobile_phone
      @patient.mobile_phone=mobile_phone
      @patient.photo=""
      if @patient.save
        @user = User.new
        @user.name=mobile_phone
        @user.mobile_phone=mobile_phone
        @user.patient_id = @patient.id
        @user.password=password
        if @user.save
          WeixinUser.where('openid=?',params[:open_id]).delete_all
          @wu=WeixinUser.new
          @wu.openid=params[:open_id]
          @wu.patient_id=@patient.id
          @wu.save
          @wu.sendByOpenId(params[:open_id],"注册成功并已成功登陆")
        end
      end
      render json:{success: true}
    end

  end
  # 注册时发送短信
  def register_send_message
    mobile_phone=params[:mobile_phone]
    open_id||=params[:open_id]
    @user=User.where(mobile_phone:mobile_phone).first
    if  !@user.nil?
      # 说明存在患者，但尚未绑定微信
      render json:{success: false,content:'此手机号码已经注册过了'}
    else
      # 没有此患者，需要注册，发送验证码
      send_message  mobile_phone
    end
    # render json:{success: true}
  end
  # 登录时获取验证码
  def login_send_message
      mobile_phone ||= params[:mobile_phone]
      open_id||=params[:open_id]
      @patient=Patient.where(mobile_phone:mobile_phone).first;
    if !@patient.nil?
       @user=User.where(patient_id:@patient.id).first
    if  !@user.nil?
      # 说明存在患者用户，但尚未绑定微信
      send_message  mobile_phone
      # render json:{success: true, content: '发送验证码成功！'}
    else
      # 说明Patient存在患者，但尚注册为公网用户
      render json:{success: false, content: '存在患者，但尚注册为公网用户！'}
    end
    else
      # 没有此患者，需要注册
      render json:{success: false, content: '没有此患者，需要注册！'}
    end
     # render json:@flag
  end

  def home
    @patient_id=params[:patient_id]
    @open_id = params[:open_id]
    @user =  Patient.find(@patient_id)
  end
  def change_user
    @open_id = params[:open_id]
    render 'weixin_patient/patient_login'
  end

  def login_delete
    open_id = params[:open_id]
    @wxu = WeixinUser.new
    @wxu.sendByOpenId(open_id,"注销登陆成功")
    WeixinUser.where("openid=?",open_id).delete_all
    render json: {success: true}
  end


  def health_record

    # @ultrasounds = InspectionUltrasound.where("patient_id=?",@patient_id).order("checked_at DESC")
    # @reports = InspectionData.where("patient_id=?",@patient_id).order("checked_at DESC")
    # @cts = InspectionCt.where("patient_id=?",@patient_id).order("checked_at DESC")
    # @nuclear_magnetism = InspectionNuclearMagnetic.where("patient_id=?",@patient_id).order("checked_at DESC")

    @open_id=@open_id # 从is_patient获取@pen_id，然后复制给@open_id, 不能去掉，否则页面收不到 @open_id的值


  end
  #   列出健康档案列表
  def health_record_list
    type=params[:type]
    open_id = params[:open_id]
    @weixin_user=WeixinUser.where(openid:open_id).first
    @ultrasounds={}
    @reports={}
    @cts={}
    @nuclear_magnetism={}
    @patient_id=@weixin_user.patient_id
    case type
      when "ultrasound"
        @ultrasounds = InspectionUltrasound.where("patient_id=?",@patient_id).order("checked_at DESC")
      when "report"
        @reports = InspectionData.where("patient_id=?",@patient_id).order("checked_at DESC")
      when "ct"
        @cts = InspectionCt.where("patient_id=?",@patient_id).order("checked_at DESC")
      when "heci"
        @nuclear_magnetism = InspectionNuclearMagnetic.where("patient_id=?",@patient_id).order("checked_at DESC")
      else

    end
  end

  #测试发送健康档案模板信息
    def send_health_tempate_message

      patient_id=params[:patient_id]
      report_id=params[:report_id]
      type=params[:type]
      key=params[:key]
      # aes加密和揭秘
      # require "aes"
      # key = '290c3c5d812a4ba7ce33adf09598a462'
      # patient_id=AES.encrypt(params[:patient_id].to_s,key)
      # report_id=  AES.encrypt(params[:report_id].to_s,key)
      WeixinUser.new.send_health_tempate_message(patient_id,report_id,type,key)
      render json:{content:"发送微信成功"}
    end

  def ultrasound
    @uuid = params[:uuid]
    id=params[:child_id]
    # AliyunMethods.connect("images")
    # @flag = AliyunMethods.exists?(@uuid, 'mimas-img') #defaultbucket
    @iu = InspectionUltrasound.where(id:params[:child_id]).first
    if !@iu.nil?
      @pics = @iu.image_list.split(',')
      # @pic1_uuid="5eec9d136b1140388aeb2f5e01b749c9.jpg"
      @pic1_uuid=@pics[0]
      @videos = @iu.video_list.split(',')
    end
  end

  def reports
    uuid = params[:uuid]
    @png = uuid.split('.')[0]+'.png'
  end
  def ct
    @obj ||= params[:uuid]
    @inspection_type||= params[:inspection_type]
  end

  def user_message
    @notifications = Notification.where('user_id=?',@patient_id)
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
  end

  def notice_delete
    Notification.where('id=?',params[:id]).first.destroy
    redirect_to "/weixin_patient/user_message?patient_id=#{params[:patient_id]}"
  end
  def friend_agree
    @notification = Notification.find(params[:id])
    doctor_id = Patient.find(params[:patient_id]).doctor_id
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
    redirect_to "/weixin_patient/user_message?patient_id=#{params[:patient_id]}"
  end
  def friend_reject
    @notification = Notification.find(params[:id])
    @notification.destroy if !@notification.nil?
    redirect_to "/weixin_patient/user_message?patient_id=#{params[:patient_id]}"
  end
  def shared
    @user = User.where("patient_id=?",@patient_id).first
    @shareds = Share.where("share_user_id=?",@user.id)
  end
  def article
    @note = Note.find(params[:note_id])
  end
  def my_doctor
    @docfs = @patient.docfriends.order("spell_code")
    @doc_id = @patient.doctor_id
    @pat_id = @patient.id
    @doc = @doc_id==""||@doc_id.nil? ? nil : Doctor.find(@doc_id)
    @action = "my_doctor"
  end
  def doctor
    @doc_id=params[:doctor_id]
    @pat_id=params[:patient_id]
    @doc = Doctor.find(@doc_id)
    @action = "doctor"
  end

  def appointment
    @doc_id = params[:doctor_id]
    p @doc_id
    @doctor = Doctor.find(@doc_id)
    @pat_id = params[:patient_id]
    @appsche = AppointmentSchedule.find(params[:app_sche_id])
  end
  def appointment_data
    as_id = params[:as_id]
    @as = AppointmentSchedule.find(as_id)
    @ar = @as.appointment_arranges.where("time_arrange=?",params[:time]).first
    doctor_id = @as.doctor_id
    app_day = @as.schedule_date
    start_time = @as.start_time
    end_time = @as.end_time
    s_time = @ar.time_arrange.to_time.strftime("%H:%M:%S")
    date_cha = end_time - start_time
    step =  date_cha/ Integer(@as.avalailbecount)
    e_time = (s_time.to_time+Integer(step)).to_time.strftime("%H:%M:%S")
    patient_id = params[:patient_id]
    @patient=Patient.find(patient_id)
    if @as.remaining_num>0
      appointment1 = Appointment.where(:patient_id => patient_id, :appointment_day => app_day)
      if Appointment.authAppointment(patient_id,as_id)
        if appointment1.count>0
          appointment1.each do|app1|
            if (app1.start_time.strftime("%H:%M:%S").to_time-s_time.to_time<=0 && s_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<0) || (app1.start_time.strftime("%H:%M:%S").to_time-e_time.to_time<0 && e_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<=0) || (app1.start_time.strftime("%H:%M:%S").to_time-s_time.to_time>0 && e_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time>0)
              msg = "不能在同一时间预约两位医生"
              flash[:success]=msg
              redirect_to :back
              return
            end
          end
        end
        @doc = Doctor.find_by_id(doctor_id)
        hospital_id = @doc.hospital_id
        department_id = @doc.department_id
        department_name = !@doc.department.nil? ? @doc.department.name : ""
        hospital_name = !@doc.hospital.nil? ? @doc.hospital.name : ""
        dictionary_id = params[:app_type]
        dictionary_name = Dictionary.find(dictionary_id).name
        appointment = Appointment.new(appointment_day:app_day,start_time:s_time.to_time.strftime("%H:%M"),end_time:e_time.to_time.strftime("%H:%M"),doctor_id:doctor_id,patient_id:patient_id,status:5,hospital_id:hospital_id,department_id:department_id,appointment_schedule_id:as_id,dictionary_id:dictionary_id,appointment_arrange_id:@ar.id,doctor_name:@doc.name,patient_name:@patient.name,department_name:department_name,hospital_name:hospital_name,dictionary_name:dictionary_name)
        if appointment.save
          @ar.update_attributes(status:1)
          remaining_num = @as.remaining_num-1
          @as.update_attributes(remaining_num:remaining_num)
          msg = "预约申请已创建，审核中。。。"
          @wxu = WeixinUser.new
          @wxu.send_message_to_weixin('patient',patient_id,msg)
          flash[:success]=msg
          redirect_to "/weixin_patient/my_appointment?patient_id=#{patient_id}"
        end
      else
        msg = "对不起，暂时无法预约,如有疑问请查看预约规则"
        flash[:success]=msg
        redirect_to :back
        return
      end
    else
      msg = "预约已满"
      flash[:success]=msg
      redirect_to :back
      return
    end
  end
  def my_appointment
    @patient_id = params[:patient_id]
    #@patient = @patient_id
    status='1,5'.split(',')
    @appointments = Appointment.where(:patient_id => @patient_id, :status => status).order('"appointment_day"').order('"start_time"')
    @cancel_appointments = Appointment.where(:patient_id => @patient_id, :status => 2)
    @complete_appointments = Appointment.where(:patient_id => @patient_id, :status => 3)

  end

  private
  #get 'login', to: 'weixin_patient#login'
  #post 'login_info', to: 'weixin_patient#login_info'
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

  def is_login
    @patient_id||=params[:patient_id]
    #@patient_id = 113932081081001
    if @patient_id==""||@patient_id.nil?
      url = Settings.weixin.sns+"appid="+Settings.weixin.app_id+"&secret="+Settings.weixin.app_secret+"&code="+params[:code]+"&grant_type=authorization_code"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      @data = JSON.parse response.body
      @open_id = @data["openid"]
      @wus = WeixinUser.where("openid=?",@open_id)
      if @wus.length==0
        login_url = "/weixin_patient/login_form?open_id=#{@open_id}"
        redirect_to login_url
      else
        @wu = @wus.first
        @patient_id = @wu.patient_id
        if @patient_id==""||@patient_id.nil?
          render "weixin_patient/is_not_patient"
        else
          @patient = Patient.find(@patient_id)
        end
      end
    else
      @patient = Patient.find(@patient_id)
    end
  end


  def send_message  mobile_phone
    #   发送验证码
    require 'securerandom'
    verify_code=rand(9999)
    input_encode='gbk'
    out_encode='utf8'
    msg=Iconv.new('gb2312','utf8').iconv("您的证码为："+verify_code.to_s+",本验证码120秒内有效【绿色医疗】")
    url=URI.escape('http://www.smsadmin.cn/smsmarketing/wwwroot/api/get_send/?uid=viicare&pwd=viicare123&mobile='+mobile_phone+'&msg='+msg)
    @rs=Iconv.new(out_encode,input_encode).iconv(Net::HTTP.get(URI(url)))
    #Net::HTTP.get得到 返回值它的返回值有：
    #0：发送成功！
    #1：用户名或密码错误！
    #2：余额不足！
    #3：超过发送最大量1000条！
    #4：此用户不允许发送！
    #5：手机号或发送信息不能为空！
    #7：超过限制字数，请修改后发送！等等
    @a=@rs.split(//).first
    if @a.to_i==0
      # @patient.update_attributes(verify_code:verify_code)
      session[:"#{mobile_phone}"]=verify_code
      render json:{flag:0,success: true}

      #返回一个登录验证码的界面
    elsif @a.to_i==2
      render json:{flag:2,success: true}
    elsif  @a.to_i==3
      render json:{flag:3}
    elsif    @a.to_i==4
      render json:{flag:4}
    elsif   @a.to_i==5
      render json:{flag:5}
    else
      render json:{flag:'位置错误'}
    end

  end
end
