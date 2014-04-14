#encoding:utf-8
require 'will_paginate/array'
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
      #flash[:success] = "您没有访问该用户信息的权限"
      redirect_to root_path
    end
  end
  def show_doctors
    @cont_doc = []
    @users = []
    @cont_doctors = current_user.patient.docfriends
    @cont_main_doctors = current_user.patient.doctor
    main_doc = {user:@cont_main_doctors,type:'主治医生'}.as_json
    @cont_doc.push(main_doc)
    @cont_doctors.each do |doc|
      doc = {user:doc,type:'我的医生'}.as_json
      @cont_doc.push(doc)
    end
    if !params[:first_name].nil? && params[:first_name] != '全部'
      @cont_doc.each do |user|
        if !/#{params[:first_name]}/.match(user['user']['spell_code'][0].upcase).nil?
          @users.push(user)
        end
      end
    else
      @users = @cont_doc
    end
    if !@users .nil?
      @contact_doctors=@users .paginate(:per_page =>10,:page => params[:page])
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
