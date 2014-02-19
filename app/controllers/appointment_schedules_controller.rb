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
    @appointmentSchedule = AppointmentSchedule.new(doctor_id:current_user.doctor_id,dayofweek:dayofWeek,timeblock:timeblock,dictionary_id:dictionary_id,avalailbecoutn:avalailbecount)
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
    respond_to do |format|
      format.html { render partial: 'appointment_schedules/myschedule'}
      format.js
    end
  end

  def cancelthisweekschedule
      cancelappscheduleId = params[:cancelappscheduleId]
      if  !cancelappscheduleId.nil?
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
        @cancelapp = AppointmentCancelSchedule.new(canceldate:cancelday,canceldoctor_id:current_user.doctor_id,canceltimeblock:@thedaytocancel.timeblock,appointment_schedule_id:@thedaytocancel.id)
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
    #render 'appointments/myapp'
    redirect_to :back
  end
  def doctorschedule
    if !params[:doctorId].nil?
      doctorId = params[:doctorId]
    else
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
          @appavalibe = AppointmentAvalible.new(avaliblecount:doctorAppSchedule.avalailbecount,avalibledoctor_id:doctorAppSchedule.doctor_id,avalibletimeblock:doctorAppSchedule.timeblock,avalibleappointmentdate:avalibleday,schedule_id:doctorAppSchedule.id,dictionary_id:doctorAppSchedule.dictionary_id)
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
            @appavalibe = AppointmentAvalible.new(avaliblecount:doctorAppSchedule.avalailbecount,avalibledoctor_id:doctorAppSchedule.doctor_id,avalibletimeblock:doctorAppSchedule.timeblock,avalibleappointmentdate:avalibleday,schedule_id:doctorAppSchedule.id,dictionary_id:doctorAppSchedule.dictionary_id)
            @appavalibe.save
          end

        end
      end
    end
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
