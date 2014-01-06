class AppointmentSchedulesController < ApplicationController
  def index
    @user = User.new
    @appointmentSchedules = @user.post_req('appointment_schedules/create',{'doctor_id' => current_user['doctor_id']})
  end

  def create
    flash[:success] = nil
    puts params[:@appointmentSchedule][:dictionary_id]
    if !(current_user.nil?) && !current_user['doctor_id'].nil?
      if params[:@appointmentSchedule][:dictionary_id].nil?
        params[:@appointmentSchedule][:dictionary_id] = '26'
      end
      params[:@appointmentSchedule][:doctorId] = current_user['doctor_id']
      doctorId = params[:@appointmentSchedule][:doctorId]
      dayofWeek = params[:@appointmentSchedule][:dayofweek]
      timeblock = params[:@appointmentSchedule][:timeblock]
      dictionary_id = params[:@appointmentSchedule][:dictionary_id]
      avalailbecount = params[:@appointmentSchedule][:avalailbecount]
      param = {'doctor_id' => doctorId, 'dayofweek' => dayofWeek, 'timeblock' => timeblock, 'dictionary_id' => dictionary_id,'avalailbecount' => avalailbecount}
      @user = User.new
      @appointmentSchedules = @user.post_req('appointment_schedules/create',param)['data']
      redirect_to :controller => 'appointments', :action => 'myappointment'
    end
  end

  def myschedule
    if !current_user.nil? && !current_user['doctor_id'].nil?
      @user = User.new
      @schedules = @user.get_req('appointment_schedules/myschedules?doctor_id='+current_user['doctor_id'].to_s)
      @appointmentSchedules = @schedules['app_schedules']
      @cancelrecords = @schedules['cancel_schedules']
    else
      redirect_to  root_path
    end
  end

  def cancelthisweekschedule
    if !current_user.nil? && !current_user['doctor_id'].nil?
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
        param={'cancelday' => cancelday, 'user_id' => current_user['id'], 'timeblock' => @thedaytocancel['timeblock'],'doctor_id' => current_user['doctor_id']}
        @user.post_req('appointment_schedules/cancelschedules',param)
      end
      redirect_to '/appointments/myappointment'
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.new
    param={'cancelappscheduleId' => params[:id]}
    @result = @user.post_req('appointment_schedules/destroy',param)
    if  !current_user.nil? && !current_user['doctor_id'].nil?
      redirect_to '/appointments/myappointment'
    else
      redirect_to root_path
    end
  end
  def doctorschedule
    if !params[:doctorId].nil?
      doctorId = params[:doctorId]
    else
      @doctorAppointSchedules = nil
      doctorId = params[:id]
    end
    param1 = {'dicionary_id' => params[:dictionary_id], 'doctorId' => doctorId}
    @schedule = @user.post_req('appointments/get_schedule',param1)
    @doctorAppointSchedules = @schedule['doctorAppointSchedules']
    @doctorAppointAvalibles = @schedule['doctorAppointAvalibles']
    avaliblecount = @doctorAppointAvalibles.count
    if (@doctorAppointSchedules.count >0)
      #可预约表中存在/不存在数据
      if  avaliblecount.eql?(0)
        #获取计划表生成未来七天数据
        #获取今天是周？  如果小于等于当前时间就是下周的  如果大于当前时间就是这周的
        @doctorAppointSchedules.each do |doctorAppSchedule|
          scheduledayofweek = doctorAppSchedule['dayofWeek']
          wtoday = Time.now.wday
          wtoday = (wtoday == 0) ? 7 : wtoday

          if (wtoday >= scheduledayofweek)
            avalibleday = (7-wtoday+scheduledayofweek).day.from_now
          else
            #这周的
            avalibleday = (scheduledayofweek - wtoday).day.from_now
          end
          ##--- 执行新增添加代码--------------------------------------------
          param2 = {'avaliblecount' => doctorAppSchedule['avalailbecount'], 'avalibledoctorId' => doctorAppSchedule['doctor_id'], 'avalibleTimeblock' => doctorAppSchedule['timeblock'],' avalibleappointmentdate' => avalibleday, 'schedule_id' => doctorAppSchedule['id'], 'dictionary_id' => doctorAppSchedule['dictionary_id']}
          @user.post_req('save_avalible',param2)
        end

        #再次获取availble中的数据  获取 取消表的数据   让 avalible中的数据 -  取消的
        #删除 取消表中的数据

      elsif  avaliblecount > 0
      end
    end
  end

end