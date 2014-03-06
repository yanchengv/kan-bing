#encoding:utf-8
class PatientsController < ApplicationController
  before_filter :signed_in_user, :except => [:public_verification]


  def patient_page
    flag = false
    if !current_user.doctor_id.nil?
      flag = TreatmentRelationship.is_friends(current_user.doctor_id,params[:id])
    end
    if !current_user['doctor_id'].nil? && flag
      @patient1 = Patient.find(params[:id])
      @patient_id = params[:id]
      @is_friends = flag
    else
      flash[:success] = "您没有访问该用户信息的权限"
      redirect_to root_path
    end
  end
  def show_doctors
    @cont_doctors = current_user.patient.docfriends
    @contact_main_doctors = current_user.patient.doctor
    if !@cont_doctors.nil?
      @contact_doctors=@cont_doctors.paginate(:per_page =>6,:page => params[:page])
    end
    render template:'patients/patient_doctors'
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
