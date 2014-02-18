class AppointmentSchedulesController < ApplicationController
  before_filter :signed_in_user
  def create
    flash[:success] = nil
    puts params[:@appointmentSchedule][:dictionary_id]
    if params[:@appointmentSchedule][:dictionary_id].nil?
      params[:@appointmentSchedule][:dictionary_id] = '26'
    end
    dayofWeek = params[:@appointmentSchedule][:dayofweek]
    timeblock = params[:@appointmentSchedule][:timeblock]
    dictionary_id = params[:@appointmentSchedule][:dictionary_id]
    avalailbecount = params[:@appointmentSchedule][:avalailbecount]
    #param = {'doctor_id' => doctorId, 'dayofweek' => dayofWeek, 'timeblock' => timeblock, 'dictionary_id' => dictionary_id,'avalailbecount' => avalailbecount,'remember_token' => current_user['remember_token']}
    #@user = User.new
    #@appointmentSchedules = @user.post_req('appointment_schedules/create',param)['data']
    @appointmentSchedule = AppointmentSchedule.new
    @appointmentSchedule.doctor_id = current_user.doctor_id#params[:doctor_id]
    @appointmentSchedule.dayofweek=dayofWeek
    @appointmentSchedule.timeblock=timeblock
    @appointmentSchedule.dictionary_id = dictionary_id
    @appointmentSchedule.avalailbecount = avalailbecount
    @tmpappSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id, :dayofweek => dayofWeek, :timeblock => timeblock)
    if @tmpappSchedule.count == 0
      @appointmentSchedule.save
    end
    @appointmentSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id)
    #render 'appointments/myapp'
    redirect_to :back
  end

  def myschedule
    @appointmentSchedules = AppointmentSchedule.where(doctor_id:current_user.doctor_id)
    @cancelrecords = AppointmentCancelSchedule.where(canceldoctor_id:current_user.doctor_id)
    @dictionary = Dictionary.where(:dictionary_type_id => 7)
      #@user = User.new
      #@schedules = @user.get_req('appointment_schedules/myschedules?doctor_id='+current_user['doctor_id'].to_s+'&remember_token='+current_user['remember_token'])
      #@appointmentSchedules = @schedules['app_schedules']
      #@cancelrecords = @schedules['cancel_schedules']
      #@dictionary = @schedules['dictionary']
    respond_to do |format|
      format.html { render partial: 'appointment_schedules/myschedule'}
      format.js
    end
  end

  def cancelthisweekschedule
      cancelappscheduleId = params[:cancelappscheduleId]
      if  !cancelappscheduleId.nil?
        #@user = User.new
        #@thedaytocancel = @user.get_req('appointment_schedules/getschedulesbyId?cancelappscheduleId=' + cancelappscheduleId.to_s+'&remember_token='+current_user['remember_token'])
        @thedaytocancel = AppointmentSchedule.find(params[:cancelappscheduleId])
        canceldayofweek = @thedaytocancel.dayofweek
        wtoday = Time.now.wday
        wtoday = (wtoday == 0) ? 7 : wtoday
        if (wtoday >= canceldayofweek)
          #取消的日期是下周的
          cancelday = (7-wtoday+canceldayofweek).day.from_now
        else
          #这周的
          cancelday = (canceldayofweek - wtoday).day.from_now
        end
        #param={'cancelday' => cancelday, 'timeblock' => @thedaytocancel['timeblock'],'remember_token' => current_user['remember_token']}
        #@user.post_req('appointment_schedules/cancelschedules',param)
        @cancelapp = AppointmentCancelSchedule.new
        @cancelapp.canceldate = cancelday
        @cancelapp.canceldoctor_id = current_user.doctor_id
        @cancelapp.canceltimeblock = @thedaytocancel.timeblock
        @cancelapp.appointment_schedule_id = @thedaytocancel.id
        @cancelapp.save
      end
      redirect_to :back
      #render 'appointments/myapp'
  end

  def destroy
    @appointmentSchedule = AppointmentSchedule.find(params[:id])
    dayofweek = @appointmentSchedule.dayofweek
    wtoday = Time.now.wday
    wtoday = (wtoday == 0) ? 7 : wtoday
    if (wtoday >= dayofweek)
      avalibleday = (7-wtoday+dayofweek).day.from_now
    else
      #这周的
      avalibleday = (dayofweek - wtoday).day.from_now
    end
    @appAvalible = AppointmentAvalible.where('"avalibledoctor_id"=? AND avalibleappointmentdate=? AND "avalibletimeblock"=?',@appointmentSchedule.doctor_id,avalibleday,@appointmentSchedule.timeblock)
    if  @appAvalible.count > 0
      appAvalible = @appAvalible.first
      appAvalible.destroy   #删除AppointmentAvalible表中对应的数据
    end
    @appointmentSchedule.destroy
    #@user = User.new
    #param={'cancelappscheduleId' => params[:id],'remember_token' => current_user['remember_token']}
    #@result = @user.post_req('appointment_schedules/destroy',param)
    #render 'appointments/myapp'
    redirect_to :back
  end
  def doctorschedule
    @user = User.new
    if !params[:doctorId].nil?
      doctorId = params[:doctorId]
    else
      #@doctor = @user.get_req('doctors/find?id=' + params[:id]+'&remember_token='+current_user['remember_token'])
      @doctor = Doctor.find(params[:id])
      str_ids = @doctor.dictionary_ids
      if str_ids != ''
        ary_ids = str_ids.split(',')
      end
      puts ary_ids[0]
      puts ary_ids[1]
      puts 'baekhyun'
      @dictionary = Dictionary.find(ary_ids)
      @doctorAppointSchedules = nil
      doctorId = params[:id]
    end
    #param1 = {'dictionary_id' => params[:dictionary_id], 'doctorId' => doctorId,'remember_token' => current_user['remember_token']}
    #@schedule = @user.post_req('appointments/get_schedule',param1)
    #@doctorAppointSchedules = @schedule['doctorAppointSchedules']
    #@doctorAppointAvalibles = @schedule['doctorAppointAvalibles']
    sql = " 1=1 "
    #dictionary_id = params[:dictionary_id]
    #if dictionary_id.nil? || dictionary_id == ''
    #  dictionary_id = 26
    #end
    sql << ' and "doctor_id"' + " = #{doctorId}"
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql << " and dictionary_id = #{dictionary_id.to_i}"
    #end
    @doctorAppointSchedules = AppointmentSchedule.where(sql)
    #sql1 = ""
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql1 << " and dictionary_id = #{dictionary_id.to_i}"
    #end
    #@doctorAppointAvalibles = AppointmentAvalible.where('"avalibledoctor_id"' + " = #{doctorId}" << sql1)
    @doctorAppointAvalibles = AppointmentAvalible.where('"avalibledoctor_id"' + " = #{doctorId}")
    avaliblecount = @doctorAppointAvalibles.count
    if (@doctorAppointSchedules.count >0)
      if  avaliblecount.eql?(0)
        #获取计划表生成未来七天数据
        #获取今天是周几  如果小于等于当前时间就是下周的  如果大于当前时间就是这周的
        @doctorAppointSchedules.each do |doctorAppSchedule|
          scheduledayofweek = doctorAppSchedule['dayofweek']
          wtoday = Time.now.wday
          wtoday = (wtoday == 0) ? 7 : wtoday

          if (wtoday >= scheduledayofweek)
            avalibleday = (7-wtoday+scheduledayofweek).day.from_now      #计算该医生可预约的日期
          else
            #这周的
            avalibleday = (scheduledayofweek - wtoday).day.from_now      #计算该医生可预约的日期
          end
          #param2 = {'avaliblecount' => doctorAppSchedule['avalailbecount'], 'avalibledoctorId' => doctorAppSchedule['doctor_id'], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday, 'schedule_id' => doctorAppSchedule['id'], 'dictionary_id' => doctorAppSchedule['dictionary_id'],'remember_token' => current_user['remember_token']}
          #@user.post_req('appointment_avalibles/save_avalible',param2)
          @appavalibe = AppointmentAvalible.new
          @appavalibe.avaliblecount = doctorAppSchedule['avalailbecount']
          @appavalibe.avalibledoctor_id = doctorAppSchedule['doctor_id']
          @appavalibe.avalibletimeblock = doctorAppSchedule['timeblock']
          @appavalibe.avalibleappointmentdate = avalibleday
          @appavalibe.schedule_id = doctorAppSchedule['id']
          #@appavalibe.dictionary_id = doctorAppSchedule['dictionary_id']
          @appavalibe.save
        end

      elsif  avaliblecount > 0
        @doctorAppointSchedules.each do |doctorAppSchedule|
          scheduledayofweek = doctorAppSchedule['dayofweek']
          wtoday = Time.now.wday
          wtoday = (wtoday == 0) ? 7 : wtoday

          if (wtoday >= scheduledayofweek)    #下周
            avalibleday = (7-wtoday+scheduledayofweek).day.from_now      #计算该医生可预约的日期
          else #这周的
            avalibleday = (scheduledayofweek - wtoday).day.from_now      #计算该医生可预约的日期
          end
          avalibleday = avalibleday.strftime("%Y/%m/%d")
          #param3 = {'dicionary_id' => params[:dictionary_id], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday,'avalibledoctorId' => doctorAppSchedule['doctor_id'],'remember_token' => current_user['remember_token']}
          #appAvalibleResult = @user.post_req('appointment_avalibles/get_avalibles2',param3)
          #dictionary_id = params[:dictionary_id]
          timeblock = doctorAppSchedule['timeblock']
          avalibleday = avalibleday
          puts avalibleday
          doctorId = doctorAppSchedule['doctor_id']
          #sql1 = ""
          #if !dictionary_id.nil? && dictionary_id != ""
          #  sql1 << " and dictionary_id = #{dictionary_id.to_i}"
          #end
          #appAvalibleResult = AppointmentAvalible.where("avalibletimeblock = #{timeblock} and avalibleappointmentdate = '#{avalibleday}' and avalibledoctor_id = #{doctorId}" << sql1)
          appAvalibleResult = AppointmentAvalible.where("avalibletimeblock = #{timeblock} and avalibleappointmentdate = '#{avalibleday}' and avalibledoctor_id = #{doctorId}")
          if appAvalibleResult.count == 0  #防止插入重复的记录
            #param2 = {'avaliblecount' => doctorAppSchedule['avalailbecount'], 'avalibledoctorId' => doctorAppSchedule['doctor_id'], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday, 'schedule_id' => doctorAppSchedule['id'], 'dictionary_id' => doctorAppSchedule['dictionary_id'],'remember_token' => current_user['remember_token']}
            #@user.post_req('appointment_avalibles/save_avalible',param2)
            @appavalibe = AppointmentAvalible.new
            @appavalibe.avaliblecount = doctorAppSchedule['avalailbecount']
            @appavalibe.avalibledoctor_id = doctorAppSchedule['doctor_id']
            @appavalibe.avalibletimeblock = doctorAppSchedule['timeblock']
            @appavalibe.avalibleappointmentdate = avalibleday
            @appavalibe.schedule_id = doctorAppSchedule['id']
            #@appavalibe.dictionary_id = doctorAppSchedule['dictionary_id']
            @appavalibe.save
          end

        end
      end
    end
    #@duplicateAppointAvalibles = @user.post_req('appointment_avalibles/get_avalibles',param1)  #删除可预约中在取消表中存在的数据，然后返回可预约表中的所有数据
    #dictionary_id = params[:dictionary_id]
    #sql1 = ""
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql1 << " and dictionary_id = #{dictionary_id.to_i}"
    #end
    duplicateAppointAvalibles = AppointmentAvalible.where(avalibledoctor_id:doctorId)
    duplicateAppointAvalibles.each do |duplicateappAvalible|
      recordInfo = AppointmentCancelSchedule.where(:canceltimeblock => duplicateappAvalible.avalibletimeblock, :canceldate => duplicateappAvalible.avalibleappointmentdate, :canceldoctor_id => duplicateappAvalible.avalibledoctor_id)
      puts recordInfo.count
      if recordInfo.count > 0
        duplicateappAvalible.destroy
      end
    end
    @duplicateAppointAvalibles = AppointmentAvalible.where("avalibledoctor_id = #{doctorId}" + " and avalibleappointmentdate > ?",Time.now)
    #@duplicateAppointAvalibles = AppointmentAvalible.where("avalibledoctor_id = #{doctorId}" + " and avalibleappointmentdate > ?" << sql1,Time.now)
    render 'appointment_schedules/doctorschedule'
  end

end
