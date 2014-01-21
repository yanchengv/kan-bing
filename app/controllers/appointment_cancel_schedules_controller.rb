class AppointmentCancelSchedulesController < ApplicationController
  before_filter :signed_in_user
  def destroy
    if  !current_user['doctor_id'].nil?
      @user = User.new
      @appointmenCancelSchedule = @user.get_req('appointment_cancel_schedules/get?cancelId='+params[:@appointmentCancelSchedule][:id].to_s+'&remember_token='+current_user['remember_token'])
      redirect_to :controller => 'appointments', :action => 'myappointment'
    end
  end

end