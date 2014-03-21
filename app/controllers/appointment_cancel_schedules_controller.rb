#class AppointmentCancelSchedulesController < ApplicationController
#  before_filter :signed_in_user
#  def destroy
#    if  !current_user['doctor_id'].nil?
#      @appointmenCancelSchedule = AppointmentCancelSchedule.find(params[:@appointmentCancelSchedule][:id])
#      @appointmenCancelSchedule.destroy
#      redirect_to :controller => 'appointments', :action => 'myappointment'
#    end
#  end
#end