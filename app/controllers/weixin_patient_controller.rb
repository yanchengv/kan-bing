#encoding:utf-8
class WeixinPatientController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout 'weixin'
  before_filter :is_patient, only: [:my_doctor]
  def my_doctor
    @docfs = @patient.docfriends.order("spell_code")
    doc_id = @patient.doctor_id
    @doc = doc_id==""||doc_id.nil? ? nil : Doctor.find(doc_id)
  end
  def appointment_doctor
    @patient = Patient.find(params[:patient_id])
    doc_id = @patient.doctor_id
    @doc = doc_id!=""&&!doc_id.nil?&&AppointmentSchedule.where("doctor_id=? and schedule_date >=?",doc_id,(Time.now+1.days).to_time.strftime("%Y-%m-%d")).length>0 ? Doctor.find(doc_id) : nil
    @docfs = @patient.docfriends.order("spell_code").select{|docfs| AppointmentSchedule.where("doctor_id=? and schedule_date >=?",docfs.id,(Time.now+1.days).to_time.strftime("%Y-%m-%d")).length>0}
  end
  def appointment
    @doctor = Doctor.find(params[:doctor_id])
    @patient_id = params[:patient_id]
    @appSches = AppointmentSchedule.where("doctor_id=? and schedule_date >=?",params[:doctor_id],(Time.now+1.days).to_time.strftime("%Y-%m-%d"))
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
          flash[:success]=msg
          redirect_to "/weixin_patient/my_doctor?patient_id=#{patient_id}"
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

  end
  private
  def is_patient
    @patient_id||=params[:patient_id]
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
        redirect_to WEIXINOAUTH
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
end
