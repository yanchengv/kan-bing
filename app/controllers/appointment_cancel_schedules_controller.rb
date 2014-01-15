class AppointmentCancelSchedulesController < ApplicationController
  before_filter :signed_in_user
  def destroy
    if  !current_user.nil? && !current_user['doctor_id'].nil?
      @user = User.new
      @appointmenCancelSchedule = @user.get_req('appointment_cancel_schedules/get?cancelId='+params[:@appointmentCancelSchedule][:id].to_s)
      redirect_to :controller => 'appointments', :action => 'myappointment'
    else
      redirect_to  root_path
    end

  end

end