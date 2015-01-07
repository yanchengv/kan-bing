#encoding:utf-8
class AppointmentsController < ApplicationController
  include HTTParty
  skip_before_filter :verify_authenticity_token,only:[:find_by_id,:sync_update,:new_appointment,:show_myappointment,:jpush]
  before_filter :signed_in_user ,except: [:find_by_id,:sync_update,:new_appointment,:show_myappointment,:jpush]
  before_filter :checksignedin, only: [:new_appointment,:show_myappointment]
=begin
  def create2
    avalibleId = params[:avalibleId]
    flash[:success]=nil
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
          appointment1 = Appointment.where(:patient_id => current_user.patient_id, :appointment_day => appday, :appointment_time => apphour, :status => 'comming')
          appointment2 = Appointment.where(:patient_id => current_user.patient_id, :doctor_id => doctorid, :appointment_day => appday, :appointment_time => apphour, :status => 'comming')
          if  appointment2.count <= 0
            if appointment1.count <= 0
              appointment = Appointment.new(appointment_day:appday,appointment_time:apphour,doctor_id:doctorid,patient_id:current_user.patient_id,status:"comming",hospital_id:Doctor.find(doctorid).hospital_id,department_id:Doctor.find(doctorid).department_id,appointment_avalibleId:avalibleId,dictionary_id:dictionary_id)
              if appointment.save
                appointment_avalible = AppointmentAvalible.find(avalibleId)
                appointment_avalible.avaliblecount -= 1
                appointment_avalible.save
                app_schedule = AppointmentSchedule.find(appointment_avalible.schedule_id)
                app_schedule.update_attributes(:remaining_num => appointment_avalible.avaliblecount)
                remind1 = '您已在 '+appointment.appointment_day.to_s+' '+ appointment.appointment_time.to_s+':00 成功预约了'+appointment.hospital.name+' '+appointment.department.name+' '+appointment.doctor.name+' 医生的'+appointment.dictionary.name+'项目'
                @notification = Notification.new(user_id:current_user.id,code:8,content:appointment.id,description:remind1,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
                @notification.save
                if appointment.doctor.users.length>0
                  remind2 = '您有一个来至于'+current_user.patient.name+'的 '+appointment.dictionary.name+' 预约在 '+appointment.appointment_day.to_s+' '+ appointment.appointment_time.to_s+':00 '
                  @notification2 = Notification.new(user_id:appointment.doctor.users.first.id,code:8,content:appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
                  @notification2.save
                end
                msg = "预约创建成功！"
                flash[:success]=msg
                redirect_to '/appointments/myappointment'
              end
            else
              msg = "不能在同一时间预约两位医生"
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
          msg = "预约已满"
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
=end
  def create
    #@weixinUser = WeixinUser.new
    scheduleId = params[:scheduleId]
    flash[:success]=nil
    if params[:dictionary_id].nil? || params[:dictionary_id] == ''
      params[:dictionary_id] = 26
    end
    dictionary_id = params[:dictionary_id]
    if !scheduleId.nil?
      @appointment_schedule = AppointmentSchedule.find_by_id(scheduleId)
      doctor_id = @appointment_schedule.doctor_id
      app_day = @appointment_schedule.schedule_date
      start_time = @appointment_schedule.start_time
      end_time = @appointment_schedule.end_time
      @app_arr = AppointmentArrange.find_by_id(params[:app_arr_id])
      #puts params[:app_time]
      s_time = @app_arr.time_arrange.to_time.strftime("%H:%M:%S")
      date_cha = end_time - start_time
      step =  date_cha/ Integer(@appointment_schedule.avalailbecount)
      e_time = (s_time.to_time+Integer(step)).to_time.strftime("%H:%M:%S")
      if @appointment_schedule.remaining_num > 0
        appointment1 = Appointment.where(:patient_id => current_user.patient_id, :appointment_day => app_day)
        #appointment2 = Appointment.where(:patient_id => current_user.patient_id, :start_time => s_time, :end_time => e_time, :appointment_schedule_id => scheduleId)
        #if appointment2.count<=0
          if Appointment.authAppointment(current_user.patient_id,scheduleId)
            if appointment1.count>0
              appointment1.each do|app1|
                #puts app1.start_time.strftime("%H:%M:%S").to_time
                #puts s_time.to_time
                if (app1.start_time.strftime("%H:%M:%S").to_time-s_time.to_time<=0 && s_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<0) || (app1.start_time.strftime("%H:%M:%S").to_time-e_time.to_time<0 && e_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<=0) || (app1.start_time.strftime("%H:%M:%S").to_time-s_time.to_time>0 && e_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time>0)
                  msg = "不能在同一时间预约两位医生"
                  flash[:success]=msg
                  redirect_to :back
                  return
                end
              end
            end
            @doc = Doctor.find_by_id(doctor_id)
            hospital_id=nil
            department_id=nil
            if !@doc.nil?
              hospital_id = @doc.hospital_id
              department_id = @doc.department_id
            end
            hospital_name=''
            department_name=''
            if !@doc.department.nil?
              department_name = @doc.department.name
            end
            if !@doc.hospital.nil?
              hospital_name = @doc.hospital.name
            end
            dictionary_name = Dictionary.find_by(id:dictionary_id).name
            #appointment = Appointment.new(appointment_day:app_day,start_time:s_time.to_time.strftime("%H:%M"),end_time:e_time.to_time.strftime("%H:%M"),doctor_id:doctor_id,patient_id:current_user.patient_id,status:5,hospital_id:hospital_id,department_id:department_id,appointment_schedule_id:scheduleId,dictionary_id:dictionary_id,appointment_arrange_id:params[:app_arr_id])
            appointment = Appointment.new(appointment_day:app_day,start_time:s_time.to_time.strftime("%H:%M"),end_time:e_time.to_time.strftime("%H:%M"),doctor_id:doctor_id,patient_id:current_user.patient_id,status:5,hospital_id:hospital_id,department_id:department_id,appointment_schedule_id:scheduleId,dictionary_id:dictionary_id,appointment_arrange_id:params[:app_arr_id],doctor_name:@doc.name,patient_name:current_user.patient.name,department_name:department_name,hospital_name:hospital_name,dictionary_name:dictionary_name)
            if appointment.save
              @app_arr.update_attributes(status:1)
              remaining_num = @appointment_schedule.remaining_num-1
              @appointment_schedule.update_attributes(remaining_num:remaining_num)
              #remind1 = '您已在 '+appointment.appointment_day.to_s+' '+ appointment.start_time.to_time.strftime("%H:%M")+' 成功预约了'+hospital+' '+department+' '+appointment.doctor.name+' 医生的'+appointment.dictionary.name+'项目'
              #@notification = Notification.new(user_id:current_user.id,code:8,content:appointment.id,description:remind1,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
              #@notification.save
              #@weixinUser.send_message_to_weixin('patient',current_user.patient_id,remind1)
              #if !appointment.doctor.user.nil?
              #  remind2 = '您有一个来至于'+current_user.patient.name+'的 '+appointment.dictionary.name+' 预约在 '+appointment.appointment_day.to_s+' '+ appointment.start_time.to_time.strftime("%H:%M")
              #  @notification2 = Notification.new(user_id:appointment.doctor.user.id,code:8,content:appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
              #  @notification2.save
              #  @weixinUser.send_message_to_weixin('doctor',appointment.doctor_id,remind2)
              #end
              msg = "预约申请已创建，审核中。。。"
              flash[:success]=msg
              redirect_to '/appointments/myappointment'
            end
          else
            msg = "对不起，暂时无法预约,如有疑问请查看预约规则"
            flash[:success]=msg
            redirect_to :back
            return
          end
        #else
        #  msg = "该预约已经存在 !"
        #  flash[:success]=msg
        #  redirect_to :back
        #  return
        #end
      else
        msg = "预约已满"
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
    sql = "status = 5 and appointment_day < '#{Time.now.to_time.strftime("%Y-%m-%d")}'"
    @apps = Appointment.where(sql)
    p @apps
    if !@apps.empty?
      @apps.each do |app|
        app.destroy
      end
    end
    if !current_user['doctor_id'].nil?
      @templates = ScheduleTemplate.where(doctor_id:current_user.doctor_id)
      @appointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => 1).order('"appointment_day"').order('"start_time"')
      @cancelappointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => 2)
      @completecancelappointments = Appointment.where(:doctor_id => current_user.doctor_id, :status => 3)
      render 'appointments/myapp'
    elsif !current_user['patient_id'].nil?
      status='1,5'.split(',')
      @appointments = Appointment.where(:patient_id => current_user.patient_id, :status => status).order('"appointment_day"').order('"start_time"')
      @cancelappointments = Appointment.where(:patient_id => current_user.patient_id, :status => 2)
      @completecancelappointments = Appointment.where(:patient_id => current_user.patient_id, :status => 3)
      @hospitals = Hospital.all
      @dictionarys = Dictionary.where(:dictionary_type_id => 7)
    end
  end
  def get_city
    @cities = City.where(:province_id => params[:province_id]).order('id')
    options = ""
    @cities.each do |city|
      options << "<option value=#{city['id']}>#{city['name']}</option>"
    end
    render :text => options
  end

  def get_hospital
    if !params[:city_id].nil? && params[:city_id] != ''
      @hospitals = Hospital.where(:city_id => params[:city_id]).order('id')
    elsif !params[:province_id].nil? && params[:province_id] != ''
      @hospitals = Hospital.where(:province_id => params[:province_id]).order('id')
    end
    options = ""
    @hospitals.each do |hos|
      options << "<option value=#{hos['id']}>#{hos['name']}</option>"
    end
    render :text => options
  end

  def get_dept
    if !params[:city_id].nil? && params[:city_id] != ''
      @departments = Department.where(:city_id => params[:city_id]).order('id')
    elsif !params[:province_id].nil? && params[:province_id] != ''
      @departments = Department.where(:province_id => params[:province_id]).order('id')
    else
      @departments = Department.where(:hospital_id => params[:hospital_id]).order('id')
    end
    options = ""
    @departments.each do |department|
      options << "<option value=#{department['id']}>#{department['name']}</option>"
    end
    render :text => options
  end

  def get_doctors
    #@app_cancels = AppointmentCancelSchedule.where('canceldate <= ?', Time.zone.now)
    #if !@app_cancels.nil?
    #  @app_cancels.each do |app_cancel|
    #    app_cancel.destroy
    #  end
    #end
    #@app_cancel_schedules = AppointmentCancelSchedule.all
    #@cancel_ids = [0]
    #if !@app_cancel_schedules.nil?
    #  @app_cancel_schedules.each do |app_cancel_schedule|
    #    @cancel_ids.push(app_cancel_schedule.appointment_schedule_id)
    #  end
    #end
    #@cancel_ids.uniq!
    #@can_ids = @cancel_ids.to_s[1..-2]
    #puts @can_ids
    #sql0 = "id not in (#{@can_ids})"
    @doctor_ids = [0]
    #@app_schedule = AppointmentSchedule.all
    sql = "schedule_date >= '#{(Time.now+1.days).to_time.strftime("%Y-%m-%d")}'"
    @app_schedule = AppointmentSchedule.where(sql)
    if !@app_schedule.nil?
      @app_schedule.each do |app_schedule|
        @doctor_ids.push(app_schedule.doctor_id)
      end
    end
    @doctor_ids.uniq!
    @doc_ids = @doctor_ids.to_s[1..-2]
    sql = "id in (#{@doc_ids})"
    province_id = params[:province_id]
    city_id = params[:city_id]
    hospital_id = params[:hospital_id]
    department_id = params[:department_id]
    #dictionary_id = params[:dictionary_id]
    #sql = ""
    if !province_id.nil? && province_id != ""
      sql << " and province_id = #{province_id} "
    end
    if !city_id.nil? && city_id != ""
      sql << " and city_id = #{city_id} "
    end
    if !hospital_id.nil? && hospital_id != ""
      sql << " and hospital_id = #{hospital_id} "
    end
    if !department_id.nil? && department_id != ""
      sql << " and department_id = #{department_id} "
    end
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql << " and id in (select "<< '"doctor_id"'<< " from appointment_schedules where dictionary_id = #{dictionary_id})"
    #end
    @doctors = Doctor.where(sql)
    #@dictionary = Dictionary.find(params[:dictionary_id])
    respond_to do |format|
      format.html {render partial: 'appointments/doctors_list'}
      format.js
    end
  end

  def tagcancel
    #@weixinUser = WeixinUser.new
    @appointment = Appointment.find_by(id:params[:id])
    if !@appointment.nil?
      hospital=''
      department=''
      if !@appointment.department.nil?
        department = @appointment.department.name
      end
      if !@appointment.hospital.nil?
        hospital = @appointment.hospital.name
      end
      @appointment.update_attributes(:status => 2)
      remind = '抱歉，您在 '+@appointment.appointment_day.to_s+' '+@appointment.start_time.to_time.strftime("%H:%M")+' 与'+hospital+' '+department+' '+@appointment.doctor.name+'医生的'+@appointment.dictionary.name+'预约被取消了。'
      @notification = Notification.new(user_id:@appointment.patient.user.id,code:8,content:@appointment.id,description:remind,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
      if !@appointment.doctor.user.nil?
        remind2 = '您在'+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")+' 与 '+@appointment.patient.name+' 的'+@appointment.dictionary.name+'已取消了。'
        @notification2 = Notification.new(user_id:@appointment.doctor.user.id,code:8,content:@appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
        @notification2.save
        #@weixinUser.send_message_to_weixin('doctor',@appointment.doctor_id,remind2)
      end
      @notification.save
      #@weixinUser.send_message_to_weixin('patient',@appointment.patient_id,remind)
    end
    respond_to do |format|
      format.js
    end
  end

  def tagabsence
    @appointment = Appointment.find_by(id:params[:id])
    if !@appointment.nil?
      @appointment.update_attributes(:status => 4)
      #获取三个月内爽约次数为三次的，  加入名单appointment_blacklists，   并且 把appointments中这三次状态修改标记为tagabsence
      appointments = Appointment.where(status:4,patient_id:@appointment.patient_id)
      #if  appointments.count == 3
      #  blacklist = Appointmentblacklist.new
      #  blacklist.patient_id = @appointment['patient_id']
      #  blacklist.unlock_time = 90.days.from_now
      #  blacklist.save
      #  appointments.each do |appointment|
      #    appointment.update_attributes(:status => 6)
      #  end
      #end
    end
    respond_to do |format|
      format.js
    end
  end

  def tagcomplete
    @appointment = Appointment.find_by(id:params[:id])
    if !@appointment.nil?
      @appointment.update_attributes(:status => 3)
    end
    respond_to do |format|
      format.js
    end
  end

  def find_by_id
    @appointment = Appointment.find_by_id(params[:appointment_id])
    render :json => {success:true, data:@appointment.as_json(:except => [:created_at, :updated_at])}
  end

  ##########################################同步接口###############################

  def sync_update
    #@weixinUser = WeixinUser.new
    @appointment=Appointment.where(id:params[:appointment_id]).first
    #hospital=''
    #department=''
    #if !@appointment.department.nil?
    #  department = @appointment.department.name
    #end
    #if !@appointment.hospital.nil?
    #  hospital = @appointment.hospital.name
    #end
    if !@appointment.nil?
      if params[:success] == 'true'
        @appointment.status=1
        @appointment.save
        if @appointment.appointment_day.to_time.strftime("%Y-%m-%d") > Time.now.to_time.strftime("%Y-%m-%d")
          p_user_id=@appointment.patient.user.id
          remind1='您有一个来至于'+@appointment.patient.name+'的 '+@appointment.dictionary.name+' 预约在 '+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")
          remind2='您已在 '+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")+' 成功预约了'+@appointment.hospital_name+' '+@appointment.department_name+' '+@appointment.doctor.name+' 医生的'+@appointment.dictionary.name+'项目'
          if !@appointment.doctor.user.nil?
            d_user_id=@appointment.doctor.user.id
            @notice = Notification.create(user_id:d_user_id,code:8,content:@appointment.id,description:remind1,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
          end
          @notice = Notification.create(user_id:p_user_id,code:8,content:@appointment.id,description:remind2,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
          remind4='您已在 '+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")+' 成功预约了'+@appointment.hospital_name+' '+@appointment.department_name+' '+@appointment.doctor.name+' 医生'
          para = {'platform'=>'all','audience'=>{'alias'=>[p_user_id]},'notification'=>{'alert'=>remind4,'android'=>{'extras'=>{'type'=>1002}},'ios'=>{'extras'=>{'type'=>1002}}}}
          response = HTTParty.post('https://api.jpush.cn/v3/push',:headers => {'Authorization'=>'Basic OGZjYTg1Y2FjZTBlNjgzYThhZWYzMzM5OjMyNDEyZWY4ZGM3N2VmMWM2YjdiNDYwZg===','Content-Type' => 'application/json'},:body => para.to_json)
          #para2 = {'platform'=>'all','audience'=>{'alias'=>[d_user_id]},'notification'=>{'alert'=>remind1,'android'=>{'extras'=>{'type'=>1002}},'ios'=>{'extras'=>{'type'=>1002}}}}
          #response = HTTParty.post('https://api.jpush.cn/v3/push',:headers => {'Authorization'=>'Basic OGZjYTg1Y2FjZTBlNjgzYThhZWYzMzM5OjMyNDEyZWY4ZGM3N2VmMWM2YjdiNDYwZg===','Content-Type' => 'application/json'},:body => para2.to_json)
          #@weixinUser.send_message_to_weixin('patient',@appointment.patient_id,remind1)
          #@weixinUser.send_message_to_weixin('doctor',@appointment.doctor_id,remind2)
        end
      else
        @appointment.status=2
        @appointment.save
        @appointment_schedule = AppointmentSchedule.find_by_id(@appointment.appointment_schedule_id)
        @appointment_schedule.remaining_num+=1
        @appointment_schedule.save
        @appointment_arrange = AppointmentArrange.find_by_id(@appointment.appointment_arrange_id)
        @appointment_arrange.status=0
        @appointment_arrange.save
        if @appointment.appointment_day.to_time.strftime("%Y-%m-%d") > Time.now.to_time.strftime("%Y-%m-%d")
          p_user_id=@appointment.patient.user.id
          remind3 = '抱歉，您在 '+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")+' 与'+@appointment.hospital_name+' '+@appointment.department_name+' '+@appointment.doctor.name+' 医生的'+@appointment.dictionary.name+'预约失败了！'
          @notice = Notification.create(user_id:p_user_id,code:8,content:@appointment.id,description:remind3,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
          remind5 = '抱歉，您在 '+@appointment.appointment_day.to_s+' '+ @appointment.start_time.to_time.strftime("%H:%M")+' 与'+@appointment.hospital_name+' '+@appointment.department_name+' '+@appointment.doctor.name+' 医生的预约失败了！'
          para = {'platform'=>'all','audience'=>{'alias'=>[p_user_id]},'notification'=>{'alert'=>remind5,'android'=>{'extras'=>{'type'=>1002}},'ios'=>{'extras'=>{'type'=>1002}}}}
          response = HTTParty.post('https://api.jpush.cn/v3/push',:headers => {'Authorization'=>'Basic OGZjYTg1Y2FjZTBlNjgzYThhZWYzMzM5OjMyNDEyZWY4ZGM3N2VmMWM2YjdiNDYwZg===','Content-Type' => 'application/json'},:body => para.to_json)
          #@weixinUser.send_message_to_weixin('patient',@appointment.patient_id,remind3)
        end
      end
    end
    render json:{success:true}
  end

  ############################## Mobile Interface ##############################
  def new_appointment
    if !app_user.patient.nil?
      arrange_id = params[:arrange_id]
      @app_arr = AppointmentArrange.find_by(id:arrange_id)
      if @app_arr.nil?
        render :json => {success:false,msg:'arrange_id无效！'}
        return
      end
      scheduleId=@app_arr.schedule_id
      @appointment_schedule = AppointmentSchedule.find_by(id:scheduleId)
      start_time = params[:start_time]
      end_time = params[:end_time]
      doctor_id = params[:doctor_id]
      app_day = @app_arr.schedule_date
      appointment1 = Appointment.where(:patient_id => app_user.patient_id, :appointment_day => app_day)
      if Appointment.authAppointment(app_user.patient_id,scheduleId)
        if appointment1.count>0
          appointment1.each do|app1|
            if (app1.start_time.strftime("%H:%M:%S").to_time-start_time.to_time<=0 && start_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<0) || (app1.start_time.strftime("%H:%M:%S").to_time-end_time.to_time<0 && end_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time<=0) || (app1.start_time.strftime("%H:%M:%S").to_time-start_time.to_time>0 && end_time.to_time-app1.end_time.strftime("%H:%M:%S").to_time>0)
              msg = "不能在同一时间预约两位医生!"
              render :json => {success:false,msg:msg}
              return
            end
          end
        end
        @doc = Doctor.find_by_id(doctor_id)
        hospital_id=nil
        department_id=nil
        if !@doc.nil?
          hospital_id = @doc.hospital_id
          department_id = @doc.department_id
        end
        hospital_name=''
        department_name=''
        if !@doc.department.nil?
          department_name = @doc.department.name
        end
        if !@doc.hospital.nil?
          hospital_name = @doc.hospital.name
        end
        #appointment = Appointment.new(appointment_day:app_day,start_time:start_time,end_time:end_time,doctor_id:doctor_id,patient_id:app_user.patient_id,status:5,hospital_id:hospital_id,department_id:department_id,appointment_schedule_id:scheduleId,dictionary_id:'',appointment_arrange_id:params[:arrange_id])
        appointment = Appointment.new(appointment_day:app_day,start_time:start_time,end_time:end_time,doctor_id:doctor_id,patient_id:app_user.patient_id,status:5,hospital_id:hospital_id,department_id:department_id,appointment_schedule_id:scheduleId,dictionary_id:'',appointment_arrange_id:params[:arrange_id],doctor_name:@doc.name,patient_name:app_user.patient.name,department_name:department_name,hospital_name:hospital_name,dictionary_name:'')
        if appointment.save
          @app_arr.update_attributes(status:1)
          remaining_num = @appointment_schedule.remaining_num-1
          @appointment_schedule.update_attributes(remaining_num:remaining_num)
          msg = "预约申请已创建，审核中。。。"
          render :json => {success:true,msg:msg,data:appointment}
        end
      else
        msg = "对不起，暂时无法预约,如有疑问请查看预约规则!"
        render :json => {success:false,msg:msg}
      end
    else
      render :json => {success:false,msg:"当前用户为医生，医生不能预约医生！"}
    end
  end

  def show_myappointment
    if !app_user['patient_id'].nil?
      status='1,2,5'.split(',')
      @appointments = Appointment.where(:patient_id => app_user.patient_id, :status => status).order('"appointment_day"').order('"start_time"')
      @apps = []
      if !@appointments.nil?
        @appointments.each do |appointment|
          #hospital_name = ''
          #department_name = ''
          #if !appointment.doctor.hospital.nil?
          #  hospital_name = appointment.doctor.hospital.name
          #end
          #if !appointment.doctor.department.nil?
          #  department_name = appointment.doctor.department.name
          #end
          app = {id:appointment.id.to_s,doctor_id:appointment.doctor_id,doctor_name:appointment.doctor.name,hospital_name:appointment.hospital_name,department_name:appointment.department_name,status:appointment.status,appointment_date:appointment.appointment_day,start_time:appointment.start_time.to_time.strftime("%H:%M"),end_time:appointment.end_time.to_time.strftime("%H:%M")}
          @apps.push(app)
        end
      end
      render :json => {success:true,data:@apps}
    else
      @appointments = Appointment.where(:doctor_id => app_user.doctor_id, :status => 1).order('"appointment_day"').order('"start_time"')
      @apps = []
      if !@appointments.nil?
        @appointments.each do |appointment|
          #hospital_name = ''
          #department_name = ''
          #if !app_user.doctor.hospital.nil?
          #  hospital_name = app_user.doctor.hospital.name
          #end
          #if !app_user.doctor.department.nil?
          #  department_name = app_user.doctor.department.name
          #end
          app = {id:appointment.id,patient_id:appointment.patient_id,patient_name:appointment.patient.name,hospital_name:appointment.hospital_name,department_name:appointment.department_name,status:appointment.status,appointment_date:appointment.appointment_day,start_time:appointment.start_time.to_time.strftime("%H:%M"),end_time:appointment.end_time.to_time.strftime("%H:%M")}
          @apps.push(app)
        end
      end
      render :json => {success:true,data:@apps}
    end
  end

end
