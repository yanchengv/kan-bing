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
      redirect_to myappointment_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.new
    param={'cancelappscheduleId' => params[:id]}
    @result = @user.post_req('appointment_schedules/destroy',param)
    if  !current_user.nil? && !current_user['doctor_id'].nil?
      redirect_to myappointment_path
    else
      redirect_to root_path
    end
  end


end
