#encoding:utf-8
require 'will_paginate/array'
class DoctorsController < ApplicationController
  skip_before_filter :verify_authenticity_token,only:[:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges]
  before_filter :signed_in_user, except:[:index_doctors_list,:index_doctor_page,:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges]#only: [:doctor_page]
  before_filter :checksignedin, only: [:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges]
  layout 'mapp', only: [:index_doctor_page]
  #首页面医生显示
  def index_doctors_list
    @doctors_all = Doctor.where("photo!=''").limit(11)
    @doctor= @doctors_all.first
    render partial: 'doctors/index_doctors_list'

  end

  #用户未登陆前察看医生主页
  def index_doctor_page
    @doctor=Doctor.find_by_id(params[:id])
    @doctor_id = params[:id]

    render 'doctors/index_doctor_page'
  end

  def doctor_page
    #if params[:id].to_i == current_user['doctor_id'].to_i
    #  redirect_to '/home'
    #end
    flag = false
    if !current_user.doctor_id.nil?
      flag = DoctorFriendship.is_friends(current_user.doctor_id, params[:id])
    elsif !current_user.patient_id.nil?
      flag = TreatmentRelationship.is_friends(params[:id], current_user.patient_id)
    end
    @doctor1 = Doctor.find(params[:id])
    @doctor_id = params[:id]
    @is_friends = flag
  end


  #医生人际关系列表 type值=>1:患者管理,2:我的同行
  def show_friends
    @doctor = current_user.doctor
    type=params[:type].to_i
    if type==1
      render template: 'doctors/doctor_patients'
    else
      @friends = Array.new
      @users = []
      @dfs1 = DoctorFriendship.where(doctor1_id: @doctor.id)
      for df1 in @dfs1
        doc1=Doctor.find(df1.doctor2_id)
        @friends.push(doc1)
      end
      @dfs2 = DoctorFriendship.where(doctor2_id: @doctor.id)
      for df2 in @dfs2
        doc2=Doctor.find(df2.doctor1_id)
        @friends.push(doc2)
      end
      if !params[:first_name].nil? && params[:first_name] != '全部'
        @friends.each do |user|
          if !/#{params[:first_name]}/.match(user['spell_code'][0].upcase).nil?
            @users.push(user)
          end
        end
      else
        @users = @friends
      end
      #@cont_doctors = @friends
      @contact_doctors = @users.paginate(:per_page => 10, :page => params[:page])
      render template: 'doctors/doctor_friends'
    end
  end

=begin
  def get_main_patients
    @doctor = current_user.doctor
    @cont_main_users = @doctor.patients
    @contact_main_users = @cont_main_users.paginate(:per_page => 18, :page => params[:page])
    render partial: 'doctors/main_user'
  end

  def get_fri_patients
    @doctor = current_user.doctor
    @cont_users = @doctor.patfriends
    @contact_users = @cont_users.paginate(:per_page => 18, :page => params[:page])
    render partial: 'doctors/fri_user'
  end
=end

  def get_patients
    @c_users = []
    @users = []
    @doctor = current_user.doctor
    @cont_main_users = @doctor.patients
    @cont_users = @doctor.patfriends

    if params[:flag] == 'main'
      @cont_main_users.each do |user|
        user = {user:user,type:'主治患者'}.as_json
        @c_users.push(user)
      end
    elsif params[:flag] == 'common'
      @cont_users.each do |user|
        user = {user:user,type:'普通患者'}.as_json
        @c_users.push(user)
      end
    elsif params[:flag] == 'all'
      @cont_main_users.each do |user|
        user = {user:user,type:'主治患者'}.as_json
        @c_users.push(user)
      end
      @cont_users.each do |user|
        user = {user:user,type:'普通患者'}.as_json
        @c_users.push(user)
      end
    end
    if !params[:first_name].nil? && params[:first_name] != '全部'
      @c_users.each do |user|
        if !/#{params[:first_name]}/.match(user['user']['spell_code'][0].upcase).nil?
          @users.push(user)
        end
      end
    else
      @users = @c_users
    end
    @user = @users.sort{|p,q| p['user']['last_treat_time']<=>q['user']['last_treat_time']}.reverse
    @contact_users = @user.paginate(:per_page => 10, :page => params[:page])
    render partial: 'doctors/con_patients'
  end


  def play_video
    @title=params[:title]
    @video_url=params[:video_url]
    render 'doctors/play_video'
  end

  ##################### Mobile Interface ####################
  def get_all_hospital
    @hospital = Hospital.all
    render json:{success:true,data:@hospital.as_json(:only => [:id,:name])}
  end


  def show_schedule_doctors
    @app_doctors = []
    @department_id = Department.select("id").where("name like ?",'%超声%科%')
    @doctors = Doctor.select("id").where(:hospital_id => params[:hospital_id],:department_id => @department_id)
    @app_sch = AppointmentSchedule.select("doctor_id,schedule_date,sum(remaining_num) as remaining_num").where("schedule_date <= ? and schedule_date > ? and doctor_id in (?)",Time.zone.now+14.days,Time.zone.now,@doctors).group("schedule_date,doctor_id")
    if !@app_sch.nil?
      @app_sch.each do |app_sch|
        @doc = {doctor_id:app_sch.doctor_id,doctor_name:app_sch.doctor.name,remaining_num:app_sch.remaining_num,schedule_date:app_sch.schedule_date}
        @app_doctors.push(@doc)
      end
      @doc2=[]
      [1,2,3,4,5,6,7,8,9,10,11,12,13,14].each do |day|
        @doc1=[]
        @app_doctors.as_json.each do |doc|
          p (Time.zone.now+day.days).strftime("%Y-%m-%d")
          if doc['schedule_date'] == (Time.zone.now+day.days).strftime("%Y-%m-%d")
            @doc1.push(doc)
          end
        end
        if !@doc1.empty?
          @doc_app1 = {schedule_date:(Time.zone.now+day.days).strftime("%Y-%m-%d"),doctors:@doc1}
          @doc2.push(@doc_app1)
        end
      end
      render :json => {success:true,data:@doc2}
    else
      render :json => {success:true,data:nil}
    end
  end

  def show_doctor_arranges
    @doctor_arrs = []
    @app_sch = AppointmentSchedule.where("schedule_date = ? and doctor_id = ?", params[:schedule_date],params[:doctor_id])
    @app_arr = AppointmentArrange.where(:schedule_id => @app_sch,:status => 0)
    @app_arr.each do |app_arr|
      @appointment_schedule = app_arr.appointment_schedule
      start_time = @appointment_schedule.start_time
      end_time = @appointment_schedule.end_time
      date_cha = end_time - start_time
      step =  date_cha/ Integer(@appointment_schedule.avalailbecount)
      s_time = app_arr.time_arrange.to_time.strftime("%H:%M:%S")
      e_time = (s_time.to_time+Integer(step)).to_time.strftime("%H:%M:%S")
      @doc_arr = {arrange_id:app_arr.id,doctor_id:app_arr.doctor_id,start_time:s_time,end_time:e_time,schedule_date:app_arr.schedule_date}
      @doctor_arrs.push(@doc_arr)
    end
    render :json => {success:true,data:@doctor_arrs}
  end

end
