#encoding:utf-8
class PatientsController < ApplicationController
  before_filter :signed_in_user, :except => [:public_verification]
  def get_aspects
    if !current_user.patient_id.nil?
      @cont_doctors = current_user.patient.docfriends
      @contact_main_doctors = current_user.patient.doctor
      @contact_doctors = @cont_doctors.paginate(:per_page =>9,:page => params[:page])
    end
    render partial: 'patients/patient_home_aspects'
  end

  def patient_page
    flag = false
    if !current_user.doctor_id.nil?
      flag = TreatmentRelationship.is_friends(current_user.doctor_id,params[:id])
    end
    if !current_user['doctor_id'].nil? && flag
      #@patient1 = @user.get_req('patients/find_patient?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
      @patient1 = Patient.find(params[:id])
      @is_friends = flag
    else
      flash[:success] = "您没有访问该用户信息的权限"
      redirect_to root_path
    end
  end
  def show_doctors
    render template:'patients/patient_doctors'
  end
  def friends
    @patient = Patient.find(params[:id])
    @cont_doctors = @patient.docfriends
    @doctor = @patient.doctor
    type=params["type"]
    if type=="1"
      if !@cont_doctors.nil?
        @contact_doctors=@cont_doctors.paginate(:per_page =>5,:page => params[:page])
      end
      @title="医生列表"
    end
    render :template => 'patients/all_friends'
  end

  def change_main_doctor
    #@current_page=params[:page]
    @doc_users=Doctor.all
    @doctor_users = @doc_users.paginate(:per_page =>5,:page => params[:page])
    render :template => "patients/change_main_doctor"
  end
  #验证公网是否有该用户
  def public_verification
    @patient = Patient.find_by_credential_type_number(params[:credential_type_number])
    if @patient
      #公网上已存在该患者
      render json: { success: true, data: @patient}
    else
      render json: { success: false}
    end
  end
end
