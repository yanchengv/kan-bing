class AppointmentsController < ApplicationController
  before_filter :signed_in_user
  def myappointment
      if !current_user['doctor_id'].nil?
        @user = User.new
        @schedules = @user.get_req('appointment_schedules/myschedules?doctor_id='+current_user['doctor_id'].to_s)
        @appointmentSchedules = @schedules['app_schedules']
        @cancelrecords = @schedules['cancel_schedules']
        @dictionary = @schedules['dictionary']
        render 'appointments/myapp'
      elsif !current_user['patient_id'].nil?
        @user = User.new
        @hospitals = @user.get_req('appointments/all_hospital')
        @dictionarys = @user.get_req('appointments/get_dictionarys?dictionary_type_id='+7.to_s)
        param = {'hospital_id' => params[:hospital_id],'department_id' => params[:department_id], 'dictionary_id' => params[:dictionary_id]}
        @doctor_users = @user.post_req('appointments/get_app_doctors',param)
        @dictionary = @user.get_req('appointments/find_dictionary?dictionary_id='+params[:dictionary_id].to_s)
      end
  end
  def get_dept
    @user = User.new
    @departments = @user.get_req('appointments/getDepartment?hospital_id='+params[:hospital_id])
    options = ""
    @departments.each do |department|
      options << "<option value=#{department['id']}>#{department['name']}</option>"
    end
    render :text => options
  end
end
