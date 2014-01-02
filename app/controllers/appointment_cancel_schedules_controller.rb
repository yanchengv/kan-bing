class AppointmentCancelSchedulesController < ApplicationController
  def destroy
    if  !current_user.nil? && !current_user['doctor_id'].nil?
      @user = User.new
      @appointmenCancelSchedule = @user.get_req('getCancelSchedules?cancelId='+params[:id].to_s)
      redirect_to :controller => 'appointments', :action => 'myappointment'
    else
      redirect_to  root_path
    end

  end

end