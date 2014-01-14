class AppointmentSchedulesController < ApplicationController

  def create
    flash[:success] = nil
    puts params[:@appointmentSchedule][:dictionary_id]
    if params[:@appointmentSchedule][:dictionary_id].nil?
      params[:@appointmentSchedule][:dictionary_id] = '26'
    end
    doctorId = current_user['doctor_id']
    dayofWeek = params[:@appointmentSchedule][:dayofweek]
    timeblock = params[:@appointmentSchedule][:timeblock]
    dictionary_id = params[:@appointmentSchedule][:dictionary_id]
    avalailbecount = params[:@appointmentSchedule][:avalailbecount]
    param = {'doctor_id' => doctorId, 'dayofweek' => dayofWeek, 'timeblock' => timeblock, 'dictionary_id' => dictionary_id,'avalailbecount' => avalailbecount}
    @user = User.new
    @appointmentSchedules = @user.post_req('appointment_schedules/create',param)['data']
    #render 'appointments/myapp'
    redirect_to :back
  end

  def myschedule
      @user = User.new
      @schedules = @user.get_req('appointment_schedules/myschedules?doctor_id='+current_user['doctor_id'].to_s)
      @appointmentSchedules = @schedules['app_schedules']
      @cancelrecords = @schedules['cancel_schedules']
      @dictionary = @schedules['dictionary']
      respond_to do |format|
        format.html { render partial: 'appointment_schedules/myschedule'}
        format.js
      end
  end

  def cancelthisweekschedule
      cancelappscheduleId = params[:cancelappscheduleId]
      if  !cancelappscheduleId.nil?
        @user = User.new
        @thedaytocancel = @user.get_req('appointment_schedules/getschedulesbyId?cancelappscheduleId=' + cancelappscheduleId.to_s)
        canceldayofweek = @thedaytocancel['dayofweek']
        wtoday = Time.now.wday
        wtoday = (wtoday == 0) ? 7 : wtoday
        if (wtoday >= canceldayofweek)
          #取消的日期是下周的
          cancelday = (7-wtoday+canceldayofweek).day.from_now
        else
          #这周的
          cancelday = (canceldayofweek - wtoday).day.from_now
        end
        param={'cancelday' => cancelday, 'timeblock' => @thedaytocancel['timeblock'],'doctor_id' => current_user['doctor_id']}
        @user.post_req('appointment_schedules/cancelschedules',param)
      end
      redirect_to :back
      #render 'appointments/myapp'
  end

  def destroy
    @user = User.new
    param={'cancelappscheduleId' => params[:id]}
    @result = @user.post_req('appointment_schedules/destroy',param)
    #render 'appointments/myapp'
    redirect_to :back
  end
  def doctorschedule
    @user = User.new
    if !params[:doctorId].nil?
      doctorId = params[:doctorId]
    else
      @doctor = @user.get_req('doctors/find?id=' + params[:id])
      @doctorAppointSchedules = nil
      doctorId = params[:id]
    end
    param1 = {'dictionary_id' => params[:dictionary_id], 'doctorId' => doctorId}
    @schedule = @user.post_req('appointments/get_schedule',param1)
    @doctorAppointSchedules = @schedule['doctorAppointSchedules']
    @doctorAppointAvalibles = @schedule['doctorAppointAvalibles']
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
          param2 = {'avaliblecount' => doctorAppSchedule['avalailbecount'], 'avalibledoctorId' => doctorAppSchedule['doctor_id'], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday, 'schedule_id' => doctorAppSchedule['id'], 'dictionary_id' => doctorAppSchedule['dictionary_id']}
          @user.post_req('appointment_avalibles/save_avalible',param2)
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
          param3 = {'dicionary_id' => params[:dictionary_id], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday,'avalibledoctorId' => doctorAppSchedule['doctor_id']}
          appAvalibleResult = @user.post_req('appointment_avalibles/get_avalibles2',param3)
          if appAvalibleResult.count == 0  #防止插入重复的记录
            param2 = {'avaliblecount' => doctorAppSchedule['avalailbecount'], 'avalibledoctorId' => doctorAppSchedule['doctor_id'], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],'avalibleappointmentdate' => avalibleday, 'schedule_id' => doctorAppSchedule['id'], 'dictionary_id' => doctorAppSchedule['dictionary_id']}
            @user.post_req('appointment_avalibles/save_avalible',param2)
          end

        end
      end
    end
    @duplicateAppointAvalibles = @user.post_req('appointment_avalibles/get_avalibles',param1)  #删除可预约中在取消表中存在的数据，然后返回可预约表中的所有数据
    render 'appointment_schedules/doctorschedule'
  end

end
