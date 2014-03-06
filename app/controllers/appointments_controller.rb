#encoding:utf-8
class AppointmentsController < ApplicationController
  before_filter :signed_in_user ,except: [:find_by_id]
  def create
    avalibleId = params[:avalibleId]
    flash[:success]=nil
    @user = User.new
    if params[:dictionary_id].nil? || params[:dictionary_id] == ''
      params[:dictionary_id] = '26'
    end
    dictionary_id = params[:dictionary_id]
    if !avalibleId.nil?
      @avalibleappointment = AppointmentAvalible.find(avalibleId)
      if Appointment.authAppointment(current_user.patient_id,avalibleId)
        if !@avalibleappointment.nil? && @avalibleappointment['avaliblecount'] > 0
          #判断用户是否已经预约过了该医生
          doctorid = @avalibleappointment.avalibledoctor_id
          appday = @avalibleappointment.avalibleappointmentdate
          apphour = @avalibleappointment.avalibletimeblock
          appointment1 = Appointment.where(:patient_id => current_user.patient_id, :appointment_day => appday, :appointment_time => apphour, :status => 'comming');
          appointment2 = Appointment.where(:patient_id => current_user.patient_id, :doctor_id => doctorid, :appointment_day => appday, :appointment_time => apphour, :status => 'comming');
          if  appointment2.count <= 0
            if appointment1.count <= 0
              #调用接口保存预约信息
              appointment = Appointment.new(appointment_day:appday,appointment_time:apphour,doctor_id:doctorid,patient_id:current_user.patient_id,status:"comming",hospital_id:Doctor.find(doctorid).hospital_id,department_id:Doctor.find(doctorid).department_id,appointment_avalibleId:avalibleId,dictionary_id:dictionary_id)
              if appointment.save
                appointment_avalible = AppointmentAvalible.find(avalibleId)
                appointment_avalible.avaliblecount -= 1
                appointment_avalible.save
                remind1 = '您已在 '+appointment.appointment_day.to_s+' '+ appointment.appointment_time.to_s+':00 成功预约了'+appointment.hospital.name+' '+appointment.department.name+' '+appointment.doctor.name+' 医生的'+appointment.dictionary.name+'项目'
                @notification = Notification.new(user_id:current_user.id,code:8,content:appointment.id,description:remind1,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
                @notification.save
                if appointment.doctor.users.length>0
                  remind2 = '您有一个来至于'+current_user.patient.name+'的 '+appointment.dictionary.name+' 预约在 '+appointment.appointment_day.to_s+' '+ appointment.appointment_time.to_s+':00 '
                  @notification2 = Notification.new(user_id:appointment.doctor.users.first.id,code:8,content:appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
                  @notification2.save
                end
                msg = "预约创建成功！";
                flash[:success]=msg
                redirect_to '/appointments/myappointment'
              end
            else
              msg = "不能在同一时间预约两位医生";
              flash[:success]=msg
              redirect_to :back
              return
            end
          else
            msg = "该预约已经存在 !"
            flash[:success]=msg
            redirect_to :back
            return
          end

        else
          msg = "预约已满";
          flash[:success]=msg
          redirect_to :back
          return
        end
      else
        msg = "对不起，暂时无法预约,如有疑问请查看预约规则"
        flash[:success]=msg
        redirect_to :back
        return
      end
    else
      msg = "预约失败，稍后再试"
      flash[:success]=msg
      redirect_to :back
      return
    end
  end
  def myappointment
    @come_items = []
    @cancel_items = []
    @complete_items = []
    if !current_user['doctor_id'].nil?
      @appointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => "comming").order('"appointment_day"').order('"appointment_time"')
      @cancelappointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => "cancel")
      @completecancelappointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => "complete")
      render 'appointments/myapp'
    elsif !current_user['patient_id'].nil?
      @appointments = Appointment.where(:patient_id => current_user.patient_id, :status => "comming").order('"appointment_day"').order('"appointment_time"')
      @cancelappointments = Appointment.where(:patient_id => current_user.patient_id, :status => "cancel")
      @completecancelappointments = Appointment.where(:patient_id => current_user.patient_id, :status => "complete")
      @hospitals = Hospital.all
      @dictionarys = Dictionary.where(:dictionary_type_id => 7)
    end
  end
  def get_dept
    @departments = Department.where(:hospital_id => params[:hospital_id]).order('id')
    options = ""
    @departments.each do |department|
      options << "<option value=#{department['id']}>#{department['name']}</option>"
    end
    render :text => options
  end
  def get_doctors
    @app_cancels = AppointmentCancelSchedule.where('canceldate <= ?', Time.zone.now)
    if !@app_cancels.nil?
      @app_cancels.each do |app_cancel|
        app_cancel.destroy
      end
    end
    @app_cancel_schedules = AppointmentCancelSchedule.all
    @cancel_ids = [0]
    if !@app_cancel_schedules.nil?
      @app_cancel_schedules.each do |app_cancel_schedule|
        @cancel_ids.push(app_cancel_schedule.appointment_schedule_id)
      end
    end
    @cancel_ids.uniq!
    @can_ids = @cancel_ids.to_s[1..-2]
    puts @can_ids
    sql0 = "id not in (#{@can_ids})"
    @doctor_ids = [0]
    @app_schedule = AppointmentSchedule.where(sql0)
    if !@app_schedule.nil?
      @app_schedule.each do |app_schedule|
        @doctor_ids.push(app_schedule.doctor_id)
      end
    end
    @doctor_ids.uniq!
    @doc_ids = @doctor_ids.to_s[1..-2]
    puts @doc_ids
    sql = "id in (#{@doc_ids})"
    hospital_id = params[:hospital_id]
    department_id = params[:department_id]
    #dictionary_id = params[:dictionary_id]
    #sql = ""
    if !hospital_id.nil? && hospital_id != ""
      sql << " and hospital_id = #{hospital_id} "
    end
    if !department_id.nil? && department_id != ""
      sql << " and department_id = #{department_id} "
    end
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql << " and id in (select "<< '"doctor_id"'<< " from appointment_schedules where dictionary_id = #{dictionary_id})"
    #end
    #if sql != ''
      @doctors = Doctor.where(sql)
    #else
    #  @doctors= nil
    #end
    #@dictionary = Dictionary.find(params[:dictionary_id])
    respond_to do |format|
      format.html {render partial: 'appointments/doctors_list'}
      format.js
    end
  end
  def tagcancel
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(:status => "cancel")
    remind = '抱歉，您在 '+@appointment.appointment_day.to_s+' '+@appointment.appointment_time.to_s+':00 与'+@appointment.hospital.name+' '+@appointment.department.name+' '+@appointment.doctor.name+'医生的'+@appointment.dictionary.name+'预约被取消了。'
    @notification = Notification.new(user_id:@appointment.patient.users.first.id,code:8,content:@appointment.id,description:remind,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
    if @appointment.doctor.users.length>0
      remind2 = '您在'+@appointment.appointment_day.to_s+' '+ @appointment.appointment_time.to_s+':00 与 '+@appointment.patient.name+' 的'+@appointment.dictionary.name+'已取消了。'
      @notification2 = Notification.new(user_id:@appointment.doctor.users.first.id,code:8,content:@appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
      @notification2.save
    end
    @notification.save
    respond_to do |format|
      format.js
    end
  end
  def tagabsence
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(:status => "absence")
    #获取三个月内爽约次数为三次的，  加入名单appointment_blacklists，   并且 把appointments中这三次状态修改标记为tagabsence
    appointments = Appointment.where(' "status" = ?  AND   "patient_id"  = ?   ', "absence", @appointment['patient_id']);
    if  appointments.count == 3
      blacklist = Appointmentblacklist.new
      blacklist.patient_id = @appointment['patient_id']
      blacklist.unlock_time = 90.days.from_now
      blacklist.save
      appointments.each do |appointment|
        appointment.update_attributes(:status => "tagabsence")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def tagcomplete
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(:status => "complete")
    respond_to do |format|
      format.js
    end
  end

  def find_by_id
    @appointment = Appointment.find(params[:appointment_id])
    render :json => {success:true, data:@appointment.as_json(:except => [:created_at, :updated_at])}
  end
end
