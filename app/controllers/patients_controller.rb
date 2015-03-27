#encoding:utf-8
require 'will_paginate/array'
class PatientsController < ApplicationController
  before_filter :signed_in_user, :except => [:public_verification,:public_verification2,:verification,:create,:update]
  before_action :token_checksingn, :only => [:verification,:create,:update]
  skip_before_filter :verify_authenticity_token , :only => [:verification,:create,:update]

  def patient_page
    flag = false
    if !current_user.doctor_id.nil?
      flag = TreatmentRelationship.is_friends(current_user.doctor_id,params[:id])
    end
    patient_id = params[:id]
    @patient_id = params[:id]
    @patient = Patient.find_by(id:patient_id)
    @photo=@patient.photo
    if !current_user.doctor_id.nil? && flag
      @is_friends = flag
      session["patient_id"]=patient_id
      session["name"]=@patient.name
      session['is_show_name']=true #判断是否在健康档案显示出姓名,如果是在远程会诊显示健康档案时，则患者的姓名需要匿名
      #render :template => 'health_records/index'
    else
      #flash[:success] = "您没有访问该用户信息的权限"
      redirect_to root_path
    end
  end
  def show_doctors
    # @cont_doc = []
    # @users = []
    # @cont_doctors = current_user.patient.docfriends
    @cont_main_doctors = current_user.patient.doctor
    if !@cont_main_doctors.nil?
      #begin 主治医生信息
      @doctor1 = current_user.patient.doctor
      @doctor_id = @doctor1.id
      @new_notes = @doctor1.notes.order("created_at desc").limit(5).publiced #最新新闻
      @notes = @doctor1.notes.order('pageview desc').limit(5).publiced #新闻点击率
      if @doctor1.user
        @consult_questions = @doctor1.user.by_consult_questions.order("created_at desc").paginate(:per_page => 9, :page => params[:page]) #医生的相关咨询
      end
      #end
    end

    # @cont_doctors.each do |doc|
    #   doc = {user:doc,type:'我的医生'}.as_json
    #   @cont_doc.push(doc)
    # end
    # if !params[:first_name].nil? && params[:first_name] != '全部'
    #   @cont_doc.each do |user|
    #     if !/#{params[:first_name]}/.match(user['user']['spell_code'][0].upcase).nil?
    #       @users.push(user)
    #     end
    #   end
    # else
    #   @users = @cont_doc
    # end
    # if !@users .nil?
    #   @contact_doctors = @users     # .paginate(:per_page =>10,:page => params[:page])
    # end
    render template:'patients/patient_doctors'
  end

  def my_doctors
    sql = "id in (select doctor_id from treatment_relationships where patient_id = #{current_user.patient_id})"
    if !params[:first_name].nil? && params[:first_name] != '全部'
      sql << " and spell_code like '#{params[:first_name].downcase}%'"
    end
    @contact_doctors = Doctor.where(sql).paginate(:per_page =>10,:page => params[:page])
    render partial: 'patients/my_doctors'
  end


  #验证公网是否有该用户

  # 公网验证用户是否存在
  def public_verification
    name=params[:name]
    credential_type_number=params[:credential_type_number]
    if name.nil? && !credential_type_number.nil?
      @patients = Patient.where(credential_type_number:credential_type_number)
    elsif credential_type_number.nil? && !name.nil?
      @patients = Patient.where(name:name)

    else !name.nil? &&!credential_type_number.nil?
      @patients = Patient.where(name:name,credential_type_number:credential_type_number)
    end

    if !@patients.empty?
      #公网上已存在该患者
      p @patients.count
      render json: { success: true, data: @patients}
        # data=[]
      # @patients.each do |patient|
      #
      # end
    else
      render json: { success: false}
    end
  end

#     患者信息修改

  def update_profile

  end

  def verification
    sql = 'false'
    if !params[:credential_type_number].nil? && params[:credential_type_number] != ''
      sql << " or credential_type_number = #{params[:credential_type_number]}"
    end
    if !params[:mobile_phone].nil? && params[:mobile_phone] != ''
      sql << " or mobile_phone = #{params[:mobile_phone]}"
    end
    if !params[:_id].nil? && params[:_id] != ''
      sql << " or _id = '#{params[:_id]}'"
    end
    if !params[:email].nil? && params[:email] != ''
      sql << " or email = #{params[:email]}"
    end
    @patient = Patient.where(sql).first
    if !@patient.nil?
      render json: {success: false, data: @patient}
    else
      render json: {success: true, data: '患者不存在!' }
    end
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: {success: true, patient: @patient}
    else
      render json: {success: false}
    end
  end

  def update
    @patient = Patient.where(id:params[:patient_id]).first
    if !@patient.nil? && @patient.update(patient_params)
      render json: {success: true, patient: @patient}
    else
      render json: {success: false}
    end
  end

  private
  def patient_params
    params.permit(:id, :name, :spell_code, :credential_type_number, :credential_type, :gender, :childbirth_date,
                  :birthday, :birthplace, :address, :nationality, :citizenship, :province, :county, :hospital_id, :department_id,
                  :photo, :marriage, :mobile_phone, :home_phone, :home_address, :contact, :contact_phone,
                  :home_postcode, :email, :introduction, :patient_ids, :education, :household, :occupation, :last_treat_time, :diseases_type,
                  :orgnization, :orgnization_address, :insurance_type, :insurance_number, :id, :doctor_id, :is_public, :p_user_id, :wechat, :created_at, :updated_at,
                  :verify_code, :is_activated, :is_checked, :verify_code_prit_count, :province_id, :city_id, :scan_code, :height,:_id)
  end
end
