#encoding:utf-8
require 'will_paginate/array'
class DoctorsController < ApplicationController
  before_filter :signed_in_user ,only:[:get_aspects,:doctor_page,:friends,:doctor_appointment]

  #首页面医生显示
  def index_doctors_list
    @doctors_all = Doctor.all
    @doctor = @doctors_all.first
    render partial: 'doctors/index_doctors_list'
  end

  #def get_aspects
  #  @contact_users = []
  #  @contact_main_users = []
  #  @contact_doctors = []
  #  if !current_user.doctor_id.nil?
  #    @doctor = current_user.doctor
  #    @cont_users = @doctor.patfriends
  #    @cont_main_users = @doctor.patients
  #    @contact_users = @cont_users.paginate(:per_page =>9,:page => params[:page])
  #    @contact_main_users = @cont_main_users.paginate(:per_page =>6,:page => params[:page])
  #    @friends = Array.new
  #    @dfs1 = DoctorFriendship.where(doctor1_id:@doctor.id)
  #    for df1 in @dfs1
  #      doc1=Doctor.find(df1.doctor2_id)
  #      @friends.push(doc1)
  #    end
  #    @dfs2 = DoctorFriendship.where(doctor2_id:@doctor.id)
  #    for df2 in @dfs2
  #      doc2=Doctor.find(df2.doctor1_id)
  #      @friends.push(doc2)
  #    end
  #    @cont_doctors = @friends
  #    @contact_doctors = @cont_doctors.paginate(:per_page =>6,:page => params[:page])
  #  end
  #  render partial: 'doctors/doctor_home_aspects'
  #end
  def doctor_page
    #if params[:id].to_i == current_user['doctor_id'].to_i
    #  redirect_to '/home'
    #end
    flag = false
    if !current_user.doctor_id.nil?
      flag = DoctorFriendship.is_friends(current_user.doctor_id,params[:id])
    elsif !current_user.patient_id.nil?
      puts params[:id]
      puts current_user.patient_id
      flag = TreatmentRelationship.is_friends(params[:id],current_user.patient_id)
    end
    @doctor1 = Doctor.find(params[:id])
    #@user = User.new
    @doctor_id = params[:id]
    @is_friends = flag
    #显示医生预约
    #@duplicateAppointAvalibles  = @user.get_req('appointment_avalibles/get_avalibles?doctorId='+params[:id].to_s+'&remember_token='+current_user['remember_token'])
  end
  #医生首页消息提醒
  def show_notices
    @home_appointments = Appointment.where(doctor_id:current_user.doctor_id, status: "comming").order('"appointment_day"').order('"appointment_time"')
    puts @home_appointments
    @home_consultations=Consultation.where(owner_id:current_user.doctor_id,status_description:'已创建').order('schedule_time')
    render partial:'doctors/home_notices'
  end


   #医生人际关系列表 type值=>1:我的患者,2:我的同行
   def show_friends
     type=params[:type].to_i
     if type==1
       render template:'doctors/doctor_patients'
     else
       render template:'doctors/doctor_friends'
     end
   end


  def friends
    @doctor = Doctor.find(params[:id])
    @cont_users = @doctor.patfriends
    @cont_main_users = @doctor.patients
    #@doctor_id = params[:id]
    @current_page = params[:page]
    @friends = []
    @dfs1 = DoctorFriendship.where(doctor1_id:params[:id])
    @dfs1.each do |dfs1|
      doc1=Doctor.find(dfs1.doctor2_id)
      @friends.push(doc1)
    end
    @dfs2 = DoctorFriendship.where(doctor2_id:params[:id])
    @dfs2.each do |dfs2|
      doc2=Doctor.find(dfs2.doctor1_id)
      @friends.push(doc2)
    end
    @cont_doctors = @friends
    @type = params["type"]
    type=params["type"]
    if type=="1"
      if !@cont_doctors.empty?
        @contact_doctors2=@cont_doctors.paginate(:per_page =>5,:page => params[:page])
      end
      @title="好友列表"
    elsif type=="2"
      if !@cont_main_users.empty?
        @contact_main_users2=@cont_main_users.paginate(:per_page =>5,:page => params[:page])
      end
      @title="主治患者列表"
    else type=="3"
      if !@cont_users.empty?
        @contact_users2=@cont_users.paginate(:per_page =>8,:page => params[:page])
      end
    @title="患者列表"
    end
    render :template => 'doctors/all_friends'
  end
end
