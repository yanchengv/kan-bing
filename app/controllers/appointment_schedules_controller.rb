#encoding:utf-8
class AppointmentSchedulesController < ApplicationController
  before_filter :signed_in_user ,except: [:doctorschedule2,:doc_schedule]
  skip_before_filter :verify_authenticity_token
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
    start_time =  params[:schedule][:start_time].to_time
    end_time = params[:schedule][:end_time].to_time
    if schedule_date.to_time <= Time.now
      msg='预约安排添加失败！预约时间只能是明天及以后！'
      #flash[:success]='预约安排添加失败！预约时间只能是明天及以后！'
      render :json => {success:false,msg:msg}
      return
    end
    if start_time < end_time
      @app_schedule = AppointmentSchedule.where(schedule_date:schedule_date,doctor_id:current_user.doctor_id)
      if !@app_schedule.nil?
        puts 'start_time'
        puts start_time
        puts 'end_time'
        puts end_time
          @app_schedule.each do |appsch|
            puts 'start'
            puts appsch.start_time.strftime("%H:%M:%S").to_time
            puts 'end'
            puts appsch.end_time.strftime("%H:%M:%S").to_time
            if ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time<=0 && start_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-end_time<0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<=0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time>0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)>0)
              puts '该时间段与已安排的计划有冲突，请重新选择安排时间。'
              #flash[:success]='预约安排添加失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
              msg = '预约安排添加失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
              render :json => {success:false,msg:msg}
              return
            end
         end
      end
      #flash[:success]='预约安排添加成功！'
      @appointmentSchedule = AppointmentSchedule.new(doctor_id:current_user.doctor_id,schedule_date:schedule_date,start_time:start_time,end_time:end_time,status:1,avalailbecount:avalailbecount,remaining_num:avalailbecount)
      @appointmentSchedule.save
      p @appointmentSchedule.id
      @appointment_schedule = AppointmentSchedule.find_by_id(@appointmentSchedule.id)
      p @appointment_schedule.id
      sch_id = @appointment_schedule.id.to_s
      p sch_id
      #@appointment_sch={id:@appointment_schedule.id,doctor_id:@appointment_schedule.doctor_id,avalailbecount:@appointment_schedule.avalailbecount,doctor_id:@appointment_schedule.doctor_id,remaining_num:@appointment_schedule.remaining_num,schedule_date:@appointment_schedule.schedule_date,start_time:@appointment_schedule.start_time,end_time:@appointment_schedule.end_time,status:@appointment_schedule.status}
      render :json => {success:true,msg:@appointment_schedule.as_json,sch_id:sch_id}
      #@appointmentSchedule = AppointmentSchedule.where(:doctor_id => current_user.doctor_id)
    else
      msg='预约安排添加失败！开始时间必须小于结束时间！'
      #flash[:success]='预约安排添加失败！开始时间必须小于结束时间！'
      render :json => {success:false,msg:msg}
    end
  end

  def myschedule
    if !params[:id].nil?
      @appointmentSchedules = AppointmentSchedule.where(doctor_id:params[:id])
    else
      @appointmentSchedules = AppointmentSchedule.where(doctor_id:current_user.doctor_id)
    end
    #@dictionary = Dictionary.where(:dictionary_type_id => 7)
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
    @appointmentSchedule = AppointmentSchedule.find_by_id(params[:id])
    @app_sch = @appointmentSchedule
    if !@appointmentSchedule.nil?
      @appointmentSchedule.destroy
    end
    #render 'appointments/myapp'
    render :json => @app_sch
    #redirect_to :back
  end
  def doctorschedule
    @doctor = Doctor.find_by_id(params[:id])
    if params[:flag].to_i == 1
      if !current_user.nil? && !current_user.doctor_id.nil? && (current_user.doctor_id==params[:id].to_i)
        @appointmentSchedules = AppointmentSchedule.where(doctor_id:params[:id])
        render partial: 'appointment_schedules/myschedules'
      else
        render partial: 'doctors/doc_appointment'
      end
    else
        render 'appointment_schedules/doctorschedules'
    end
  end

  def doctorschedule2
    @doctor = Doctor.find_by_id(params[:id])
    if !@doctor.nil?
      render  partial: 'doctors/doc_app'
    else
      render json:{}
    end
  end

  def doc_schedule
    #@dictionary = nil
    #@doctor = Doctor.find(params[:id])
    #str_ids = @doctor.dictionary_ids
    #if str_ids != '' && !str_ids.nil?
    #  ary_ids = str_ids.split(',')
    #  @dictionary = Dictionary.find(ary_ids)
    #end
    if !params[:id].nil?
      if !current_user.nil? && !current_user.patient.nil?
        id = params[:id]
        sql = "doctor_id = #{id} and schedule_date >= '#{(Time.now+1.days).to_time.strftime("%Y-%m-%d")}'"
        @appointmentSchedules = AppointmentSchedule.where(sql)
        #@appointmentSchedules = AppointmentSchedule.where('doctor_id = ?  AND  schedule_date  >=  ?', params[:id],Time.now+7.days)
      else
        @appointmentSchedules = AppointmentSchedule.where(doctor_id:params[:id])
      end
    end
    #@dictionary = Dictionary.where(:dictionary_type_id => 7)
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
    @app_sch = AppointmentSchedule.find_by_id(params[:id])
    @dictionary = nil
    @doctor = Doctor.find_by_id(@app_sch.doctor_id)
    str_ids = @doctor.dictionary_ids
    if str_ids != '' && !str_ids.nil?
      ary_ids = str_ids.split(',')
      #@dictionary = Dictionary.find(ary_ids)
      @dictionary = Dictionary.where(:id=>ary_ids)
    end
    if !current_user.patient.nil? || (current_user.doctor_id.to_i!=@app_sch.doctor_id.to_i)
      render partial: 'appointments/create_appointment'
    else
      @appointment = Appointment.where(appointment_schedule_id:params[:id],status:1)
      render partial: 'appointment_schedules/show_appointment_schedules'
    end
  end

  def updateschedule
    flash[:success]=nil
    if params[:app][:schedule_date].to_time <= Time.now
      #flash[:success]='预约安排添加失败！预约时间只能是明天及以后！'
      puts '预约安排修改失败！预约时间只能是明天及以后！'
      msg = '预约安排修改失败！预约时间只能是明天及以后！'
      render :json => {success:false,msg:msg}
      return
    end
    if params[:app][:start_time].to_time < params[:app][:end_time].to_time
    @app_schedule = AppointmentSchedule.where(schedule_date:params[:app][:schedule_date],doctor_id:current_user.doctor_id)
    if !@app_schedule.nil?
      @app_schedule.each do |appsch|
        puts appsch.start_time
        if appsch.id != params[:app][:schedule_id].to_i
          if (appsch.start_time.strftime("%H:%M:%S").to_time<=params[:app][:start_time].to_time && params[:app][:start_time].to_time<appsch.end_time.strftime("%H:%M:%S").to_time) || (appsch.start_time.strftime("%H:%M:%S").to_time<params[:app][:end_time].to_time && params[:app][:end_time].to_time<=appsch.end_time.strftime("%H:%M:%S").to_time) || (appsch.start_time.strftime("%H:%M:%S").to_time>params[:app][:start_time].to_time && params[:app][:end_time].to_time>appsch.end_time.strftime("%H:%M:%S").to_time)
            puts '该时间段与已安排的计划有冲突，请重新选择安排时间。'
            msg = '预约安排修改失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            #flash[:success]='预约安排修改失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            render :json => {success:false,msg:msg}
            return
          end
        end
      end
    end
    #flash[:success]='预约安排修改成功！'
    @app_sch = AppointmentSchedule.find_by_id(params[:app][:schedule_id])
    @app_sch.update_attributes(avalailbecount:params[:app][:avalailbecount],schedule_date:params[:app][:schedule_date],start_time:params[:app][:start_time],end_time:params[:app][:end_time],status:params[:app][:status],remaining_num:params[:app][:remaining_num])
    render :json => {success:true,msg:@app_sch}
    else
      msg = '预约安排修改失败！开始时间必须小于结束时间！'
      #flash[:success]='预约安排修改失败！开始时间必须小于结束时间！'
      render :json => {success:false,msg:msg}
    end
  end

  def schedule_template
    @templates = ScheduleTemplate.where(doctor_id:current_user.doctor_id)
    year=params[:year].to_i
    month=params[:month].to_i
    @flag=true
    if !@templates.nil?
      @schedules = []
      @templates.each do |template|
        day=1
        start_time =  template.start_time.strftime("%H:%M:%S").to_time
        end_time = template.end_time.strftime("%H:%M:%S").to_time
        date=Date.new(year, month, day)
        while Date.valid_date?(year, month, day)
          if date.wday.to_i == template.dayofweek.to_i
            schedule_date=date
            @app_schedule = AppointmentSchedule.where(schedule_date:schedule_date,doctor_id:current_user.doctor_id)
            if !@app_schedule.nil?
              @app_schedule.each do |appsch|
                if ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time<=0 && start_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-end_time<0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<=0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time>0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)>0)
                  msg = '添加失败！时间段与已安排的计划有冲突。'
                  @flag=false
                  render :json => {success:false,msg:msg}
                  return
                end
              end
            end
          end
          date+=1
          day+=1
        end
      end
      if @flag
        @templates.each do |template|
          day=1
          avalailbecount = template.number
          start_time =  template.start_time.strftime("%H:%M:%S").to_time
          end_time = template.end_time.strftime("%H:%M:%S").to_time
          date=Date.new(year, month, day)
          while Date.valid_date?(year, month, day)
            if date.wday.to_i == template.dayofweek.to_i
              schedule_date=date
              @appointmentSchedule = AppointmentSchedule.new(doctor_id:current_user.doctor_id,schedule_date:schedule_date,start_time:start_time,end_time:end_time,status:1,avalailbecount:avalailbecount,remaining_num:avalailbecount)
              if @appointmentSchedule.save
                @sch = AppointmentSchedule.find_by(id:@appointmentSchedule.id)
                p @sch.id
                app_sch = {id:@sch.id.to_s,doctor_id:@sch.doctor_id,schedule_date:@sch.schedule_date,start_time:@sch.start_time.strftime("%H:%M"),end_time:@sch.end_time.strftime("%H:%M"),avalailbecount:@sch.avalailbecount,status:@sch.status,remaining_num:@sch.remaining_num}
                @schedules.push(app_sch.as_json)
              else
                render :json => {success:false,msg:'数据库保存数据出错！可能部分插入成功！'}
              end
            end
            date+=1
            day+=1
          end
        end

      end
      render :json => {success:true,msg:@schedules}
    end
  end

  def find_by_id
    @appointment_schedule = AppointmentSchedule.find_by_id(params[:id])
    render :json => {success:true, data:@appointment_schedule .as_json(:except => [:created_at, :updated_at])}
  end
end
