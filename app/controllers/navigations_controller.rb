#encoding:utf-8
require 'open-uri'
class NavigationsController < ApplicationController
  before_filter :signed_in_user,except: [:signed_mini,:remote_consultation]
  def signed_mini
    user = User.find_by(name: [params[:session][:username]])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if params[:flag]=='1'
        patID = current_user.patient_id
        docID = current_user.doctor_id
        if !patID.nil?
          redirect_to '/navigations/navigationhealthrecord'
        elsif !docID.nil?
          redirect_to '/doctors/show_friends/?type=1'
        end
      elsif params[:flag]=='2'
        render :template => 'consultations/index'
      elsif params[:flag]=='3'
        redirect_to '/appointments/myappointment'
      else
        redirect_to '/doctors/doctorpage/'+params[:flag]
      end
    else
      flash[:success] = '登录失败！'
      redirect_to '/'
    end
  end

  def navigation_health_record

    flag = false
    if !current_user.doctor_id.nil?
      flag = TreatmentRelationship.is_friends(current_user.doctor_id,params[:id])
    end
    patient_id = current_user.patient_id
    if patient_id.nil? || patient_id == ''
      patient_id = params[:id]
    end
    #血糖
    @blood_glucoses = BloodGlucose.where(:patient_id => patient_id)
    blood_glucoses_sum = 0
    @blood_glucoses_avg = 0
    if !@blood_glucoses.nil? && @blood_glucoses.count!=0
      @blood_glucoses.each do |blood_glu|
        blood_glucoses_sum += blood_glu.measure_value.to_i
      end
      @blood_glucoses_avg = (blood_glucoses_sum.to_f/@blood_glucoses.count).round(2)
    end
    #血压
    @blood_pressures = BloodPressure.where(patient_id:patient_id)
    systolic_pressure_sum = 0
    diastolic_pressure_sum = 0
    @systolic_pressure_avg = 0
    @diastolic_pressure_avg = 0
    if !@blood_pressures.nil? && @blood_pressures.count!=0
      @blood_pressures.each do |blood_press|
        systolic_pressure_sum += blood_press.systolic_pressure.to_i
        diastolic_pressure_sum += blood_press.diastolic_pressure.to_i
      end
      @systolic_pressure_avg =  (systolic_pressure_sum.to_f/@blood_pressures.count).round(1)
      @diastolic_pressure_avg = (diastolic_pressure_sum.to_f/@blood_pressures.count).round(1)
      #@systolic_pressure_avg = 100
      #@diastolic_pressure_avg = 80
    end
    #体重
    @weight = Weight.where(:patient_id => patient_id)
    weight_sum = 0
    @weight_avg = 0
    if !@weight.nil? && @weight.count!=0
      @weight.each do |weight|
        weight_sum += weight.weight_value.to_i
      end
      @weight_avg = (weight_sum.to_f/@weight.count).round(1)
    end

    #基本健康信息
    @basic_health_record = BasicHealthRecord.where(:patient_id => patient_id).first
    @patient_id = patient_id
    @patient = Patient.find_by(id:patient_id)
    @photo=nil
    if !@patient.nil?
      @photo=@patient.photo
    end
    @is_friends = flag
    session["patient_id"]=patient_id
    render :template => 'patients/patient_page'
  end

  def remote_consultation
    if signed_in?
      @my_consultations = current_user.managed_cons
      @joined_consultations = current_user.joined_cons
      @cons_record = @my_consultations.concat(@joined_consultations)
      @cons_record.sort_by { |u| u.created_at }
      @applied_consultations = current_user.applied_cons
      @invited_master_consultations = current_user.invited_master_cons
      @invited_consultations = current_user.invited_cons
      @invited_consultations.sort_by { |u| u.created_at }
      render :template => 'navigations/remote_consultation'
    else
      redirect_to root_path
    end
    store_location
  end
end