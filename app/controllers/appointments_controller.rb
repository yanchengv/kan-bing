class AppointmentsController < ApplicationController
  def myappointment
      if !current_user['doctor_id'].nil?
        render 'appointments/myapp'
      else
      end
  end
end
