#encoding:utf-8
class AppointmentSchedulesController < ApplicationController
  before_filter :signed_in_user ,except: [:doctorschedule,:doc_schedule]
=begin
  def create2
    flash[:success] = nil
    puts params[:@appointmentSchedule][:dictionary_id]
    #if params[:@appointmentSchedule][:dictionary_id].nil?
    #  params[:@appointmentSchedule][:dictionary_id] = '26'
    #end
    dayofWeek = params[:@appointmentSchedule][:dayofweek]
    timeblock = params[:@appointmentSchedule][:timeblock]
    #dictionary_id = params[:@appointmentSchedule][:dictionary_id]
    avalailbecount = params[:@appointmentSchedule][:avalailbecount]
    @appointmentSchedule = AppointmentSchedule.new(doctor_id:current_user.doctor_id,dayofweek:dayofWeek,timeblock:timeblock,avalailbecount:avalailbecount,remaining_num:avalailbecount)
    @tmpappSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id, :dayofweek => dayofWeek, :timeblock => timeblock)
    if @tmpappSchedule.count == 0
      @appointmentSchedule.save
    end
    @appointmentSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id)
    #render 'appointments/myapp'
    redirect_to :back
  end
=end
  def create
    flash[:success]=nil
    avalailbecount = params[:schedule][:avalailbecount].to_i
    schedule_date = params[:schedule][:schedule_date]
    start_time =  params[:schedule][:start_time].to_i
    end_time = params[:schedule][:end_time].to_i
    @app_schedule = AppointmentSchedule.where(schedule_date:schedule_date,doctor_id:current_user.doctor_id)
    if !@app_schedule.nil?
        @app_schedule.each do |appsch|
          if (appsch.start_time<=start_time && start_time<=appsch.end_time) || (appsch.start_time<=end_time && end_time<=appsch.end_time)
            puts '该时间段与已安排的计划有冲突，请重新选择安排时间。'
            flash[:success]='预约安排添加失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            redirect_to :back
            return
          end
       end
    end
    flash[:success]='预约安排添加成功！'
    @appointmentSchedule = AppointmentSchedule.new(doctor_id:current_user.doctor_id,schedule_date:schedule_date,start_time:start_time,end_time:end_time,status:1,avalailbecount:avalailbecount,remaining_num:avalailbecount)
    @appointmentSchedule.save
    #@appointmentSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id)
    redirect_to :back
  end

  def myschedule
    if !params[:id].nil?
      @appointmentSchedules = AppointmentSchedule.where(doctor_id:params[:id])
    else
      @appointmentSchedules = AppointmentSchedule.where(doctor_id:current_user.doctor_id)
    end
    @dictionary = Dictionary.where(:dictionary_type_id => 7)
    respond_to do |format|
      #format.html { render partial: 'appointment_schedules/myschedule'}
      format.html { render partial: 'appointment_schedules/myschedules'}
      format.js
    end
  end
=begin
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
=end
  def destroy
    @appointmentSchedule = AppointmentSchedule.find(params[:id])
    @appointmentSchedule.destroy
    #render 'appointments/myapp'
    redirect_to :back
  end
  def doctorschedule
    @doctor = Doctor.find(params[:id])
    if params[:flag].to_i == 1
      render partial: 'doctors/doc_appointment'
    else
      render 'appointment_schedules/doctorschedules'
    end
  end

  def doc_schedule
    @dictionary = nil
    @doctor = Doctor.find(params[:id])
    str_ids = @doctor.dictionary_ids
    if str_ids != '' && !str_ids.nil?
      ary_ids = str_ids.split(',')
      @dictionary = Dictionary.find(ary_ids)
    end
    if !params[:id].nil?
      @appointmentSchedules = AppointmentSchedule.where(doctor_id:params[:id])
    end
    @dictionary = Dictionary.where(:dictionary_type_id => 7)
    render partial:'appointment_schedules/doc_schedule'
  end

=begin
  def doctorschedule2
    #if !params[:doctorId].nil?
    #  doctorId = params[:doctorId]
    #else
    @dictionary = nil
      @doctor = Doctor.find(params[:id])
      str_ids = @doctor.dictionary_ids
      if str_ids != '' && !str_ids.nil?
        ary_ids = str_ids.split(',')
        @dictionary = Dictionary.find(ary_ids)
      end
      puts 'baekhyun'
      doctorId = params[:id]
    #end
    #dictionary_id = params[:dictionary_id]
    #if dictionary_id.nil? || dictionary_id == ''
    #  dictionary_id = 26
    #end
    #@doctorAppointSchedules = AppointmentSchedule.where(doctor_id:doctorId,dictionary_id:dictionary_id)
    @doctorAppointSchedules = AppointmentSchedule.where(doctor_id:doctorId)
    #sql1 = ""
    #if !dictionary_id.nil? && dictionary_id != ""
    #  sql1 << " and dictionary_id = #{dictionary_id.to_i}"
    #end
    #@doctorAppointAvalibles = AppointmentAvalible.where('"avalibledoctor_id"' + " = #{doctorId}" << sql1)
    @doctorAppointAvalibles = AppointmentAvalible.where(:avalibledoctor_id => doctorId)
    avaliblecount = @doctorAppointAvalibles.count
    puts @doctorAppointSchedules.count
    if (@doctorAppointSchedules.count >0)
      if  avaliblecount.eql?(0)
        #获取计划表生成未来七天数据
        #获取今天是周几  如果小于等于当前时间就是下周的  如果大于当前时间就是这周的
        @doctorAppointSchedules.each do |doctorAppSchedule|
          scheduledayofweek = doctorAppSchedule['dayofweek']
          wtoday = Time.now.wday
          wtoday = (wtoday == 0) ? 7 : wtoday
          [1,2,3,4].each do |num|
            puts num
          if (wtoday >= scheduledayofweek)
            avalibleday = (num*7-wtoday+scheduledayofweek).day.from_now      #计算该医生可预约的日期
          else
            #这周的
            avalibleday = ((num-1)*7+scheduledayofweek - wtoday).day.from_now      #计算该医生可预约的日期
          end
          @appavalibe = AppointmentAvalible.new(avaliblecount:doctorAppSchedule.remaining_num,avalibledoctor_id:doctorAppSchedule.doctor_id,avalibletimeblock:doctorAppSchedule.timeblock,avalibleappointmentdate:avalibleday,schedule_id:doctorAppSchedule.id,dictionary_id:doctorAppSchedule.dictionary_id)
          @appavalibe.save
          end
        end

      elsif  avaliblecount > 0
        @doctorAppointSchedules.each do |doctorAppSchedule|
          scheduledayofweek = doctorAppSchedule['dayofweek']
          wtoday = Time.now.wday
          wtoday = (wtoday == 0) ? 7 : wtoday
          [1,2,3,4].each do |num|
            puts num
          if (wtoday >= scheduledayofweek)    #下周
            avalibleday = (num*7-wtoday+scheduledayofweek).day.from_now      #计算该医生可预约的日期
          else #这周的
            avalibleday = ((num-1)*7+scheduledayofweek - wtoday).day.from_now      #计算该医生可预约的日期
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
          appAvalibleResult = AppointmentAvalible.where(:avalibletimeblock => timeblock,:avalibleappointmentdate => avalibleday, :avalibledoctor_id => doctorId)
          if appAvalibleResult.count == 0  #防止插入重复的记录
            @appavalibe = AppointmentAvalible.new(avaliblecount:doctorAppSchedule.remaining_num,avalibledoctor_id:doctorAppSchedule.doctor_id,avalibletimeblock:doctorAppSchedule.timeblock,avalibleappointmentdate:avalibleday,schedule_id:doctorAppSchedule.id,dictionary_id:doctorAppSchedule.dictionary_id)
            @appavalibe.save
          end
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
    if params[:flag].to_i == 1
      render partial: 'doctors/doctor_appointment'
    else
      render 'appointment_schedules/doctorschedule'
    end
  end
=end
  def show_appschedules
    @app_sch = AppointmentSchedule.find(params[:id])
    @dictionary = nil
    @doctor = Doctor.find(@app_sch.doctor_id)
    str_ids = @doctor.dictionary_ids
    if str_ids != '' && !str_ids.nil?
      ary_ids = str_ids.split(',')
      @dictionary = Dictionary.find(ary_ids)
    end
    if !current_user.patient.nil? || (current_user.doctor_id.to_i!=@app_sch.doctor_id.to_i)
      render partial: 'appointments/create_appointment'
    else
      #@appointment = Appointment.where(appointment_schedule_id:params[:id],status:1)
      render partial: 'appointment_schedules/show_appointment_schedules'
    end
  end

  def updateschedule
    flash[:success]=nil
    @app_schedule = AppointmentSchedule.where(schedule_date:params[:app][:schedule_date],doctor_id:current_user.doctor_id)
    if !@app_schedule.nil?
      @app_schedule.each do |appsch|
        puts appsch.start_time
        if appsch.id != params[:app][:schedule_id].to_i
          if (appsch.start_time<=params[:app][:start_time].to_i && params[:app][:start_time].to_i<=appsch.end_time) || (appsch.start_time<=params[:app][:end_time].to_i && params[:app][:end_time].to_i<=appsch.end_time)
            puts '该时间段与已安排的计划有冲突，请重新选择安排时间。'
            flash[:success]='预约安排修改失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            redirect_to :back
            return
          end
        end
      end
    end
    flash[:success]='预约安排修改成功！'
    @app_sch = AppointmentSchedule.find(params[:app][:schedule_id])
    @app_sch.update_attributes(avalailbecount:params[:app][:avalailbecount],schedule_date:params[:app][:schedule_date],start_time:params[:app][:start_time],end_time:params[:app][:end_time],status:params[:app][:status],remaining_num:params[:app][:remaining_num])
    redirect_to :back
  end
end
