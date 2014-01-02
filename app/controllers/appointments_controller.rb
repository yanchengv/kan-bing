class AppointmentsController < ApplicationController
  before_filter :signed_in_user
  def myappointment
      if !current_user['doctor_id'].nil?
        @user = User.new
        @schedules = @user.get_req('myschedules?doctor_id='+current_user['doctor_id'].to_s)
        @appointmentSchedules = @schedules['app_schedules']
        @cancelrecords = @schedules['cancel_schedules']
        @dictionary = @schedules['dictionary']
        render 'appointments/myapp'
      elsif !current_user['patient_id'].nil?

      end
  end
end
