#encoding:utf-8
require 'will_paginate/array'
class DoctorsController < ApplicationController
  skip_before_filter :verify_authenticity_token,only:[:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges,:get_doc_by_id, :index_doctor, :get_doctor_to_page]
  before_filter :signed_in_user, except:[:index_doctors_list,:index_doctor_page,:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges,:get_doc_by_id, :index_doctor, :get_doctor_to_page]
  before_filter :checksignedin, only: [:get_all_hospital,:show_schedule_doctors,:show_doctor_arranges,:get_doc_by_id]
  layout 'kanbing365', only: [:index_doctor_page, :index_doctor]

  #首页面医生显示
  def index_doctors_list

     # expertise = params[:expertise].to_s
     #  if !expertise.nil?  && expertise != ''
     #
     #   expertise = expertise.to_s
     #   @doctors_all = Doctor.indexpage_and_asc.distinct(:name).limit(11).where(:expertise => expertise)
     #  else
     #   @doctors_all = Doctor.indexpage_and_asc.distinct(:name).limit(11)
     #
     # end
     # @doctors_all=Doctor.find(["113932081080033","772768100000004","113932081080026","113932081080019","114099149026965","750651300000003","750651300000001","750652000000141","750904700000194","773979300000003","775709300000101"])
     #  @doctors_all=Doctor.find(["113932081080033"])
     @doctors_all=Doctor.find(["113932081080033","773498800000074","773979700000097","773106200000636","113932081080019","765239200000143","759125700000026","774501100001184","765431100000152","775709300000101","750904100000073"])

     if @doctors_all.count > 0
        @doctor= @doctors_all.first
    else
        @doctor
     end
  
    render partial: 'doctors/index_doctors_list'

  end

  #获取首页面上医生的显示信息
  def get_doctor_to_page
    @doctor = Doctor.find(params[:id])
    if !@doctor.photo.nil? && @doctor.photo != ''
      if aliyun_file_exit('avatar/'+@doctor.photo, Settings.aliyunOSS.image_bucket) || aliyun_file_exit('avatar/'+@doctor.photo.strip, Settings.aliyunOSS.image_bucket)
        @doctor.photo = photo_access_url_prefix_with(@doctor.photo)
      else
        @doctor.photo = 'http://mimas-img.oss-cn-beijing.aliyuncs.com/352460d5-f56c-4439-99a1-0c17f8964e41.png'
      end
    else
      @doctor.photo = 'http://mimas-img.oss-cn-beijing.aliyuncs.com/352460d5-f56c-4439-99a1-0c17f8964e41.png'
    end
    if @doctor
      render :json => {:success => true, :doctor => @doctor.as_json(:include => [{:hospital => {:only => [:id, :name]}}, {:department => {:only => [:id, :name]}}])}
    else
      render :json => {:success => false}
    end

  end

  #用户未登陆前察看医生主页
  def index_doctor
    @doctor=Doctor.find_by_id(params[:id])
    if @doctor.nil?
      render json: {:success => false}
    else
      render json: {:success => true}
    end
  end
  #用户未登陆前察看医生主页

  def index_doctor_page
    @doctor=Doctor.find_by_id(params[:id])
    @doctor_id = params[:id]
    if @doctor.user.nil?
      render 'doctors/index_doctor_not_user'
    else
      @new_notes = @doctor.notes.order("created_at desc").limit(5).publiced #最新新闻
      @notes = @doctor.notes.order('pageview desc').limit(5).publiced #新闻点击率
      @consult_questions = @doctor.user.by_consult_questions.paginate(:per_page => 9, :page => params[:page]) #医生的相关咨询
      render 'doctors/index_doctor_page'
    end
  end

  def doctor_page
    #if params[:id].to_i == current_user['doctor_id'].to_i
    #  redirect_to '/home'
    #end
    # require "base64"
    # params[:id] = Base64.decode64 params[:id]
    flag = false
    if !current_user.doctor_id.nil?
      flag = DoctorFriendship.is_friends(current_user.doctor_id, params[:id])
    elsif !current_user.patient_id.nil?
      flag = TreatmentRelationship.is_friends(params[:id], current_user.patient_id)
    end
    @doctor1 = Doctor.find_by(id:params[:id])
    @doctor_id = params[:id]
    if @doctor1.user.nil?
      @doctor = @doctor1
      render 'doctors/index_doctor_not_user'
    else
      @new_notes = @doctor1.notes.order("created_at desc").limit(5).publiced #最新新闻
      @notes = @doctor1.notes.order('pageview desc').limit(5).publiced #新闻点击率
      @consult_questions = @doctor1.user.nil? ? [] : @doctor1.user.by_consult_questions.order("created_at desc").paginate(:per_page => 9, :page => params[:page]) #医生的相关咨询
      @is_friends = flag
      render 'doctors/doctor_page'
    end

  end


  #医生人际关系列表 type值=>1:患者管理,2:我的同行
  def show_friends
    @doctor = current_user.doctor
    type=params[:type].to_i
    if type==1
      render template: 'doctors/doctor_patients'
    else
=begin
      @friends = Array.new
      @users = []
      @dfs1 = DoctorFriendship.where(doctor1_id: @doctor.id)
      for df1 in @dfs1
        doc1=Doctor.find_by(id:df1.doctor2_id)
        @friends.push(doc1)
      end
      @dfs2 = DoctorFriendship.where(doctor2_id: @doctor.id)
      for df2 in @dfs2
        doc2=Doctor.find_by(id:df2.doctor1_id)
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
=end
      sql = "id in (select doctor2_id from doctor_friendships where doctor1_id = #{@doctor.id} UNION select doctor1_id from doctor_friendships where doctor2_id = #{@doctor.id})"
      if !params[:first_name].nil? && params[:first_name] != '全部'
        sql << " and spell_code like '#{params[:first_name].downcase}%'"
      end
      @users = Doctor.where(sql)

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
    @contact_users = []
    @doctor = current_user.doctor
    sql1 = "doctor_id = #{@doctor.id}"
    sql2 = "id in (SELECT patients.id FROM patients INNER JOIN treatment_relationships ON patients.id = treatment_relationships.patient_id WHERE treatment_relationships.doctor_id = #{@doctor.id})"
    sql3 = "(id in (SELECT patients.id FROM patients INNER JOIN treatment_relationships ON patients.id = treatment_relationships.patient_id WHERE treatment_relationships.doctor_id = #{@doctor.id}) or doctor_id = #{@doctor.id})"
    if !params[:first_name].nil? && params[:first_name] != '全部'
      sql1 << " and spell_code like '#{params[:first_name].downcase}%'"
      sql2 << " and spell_code like '#{params[:first_name].downcase}%'"
      sql3 << " and spell_code like '#{params[:first_name].downcase}%'"
    end
    @cont_main_users = @doctor.patients
    @cont_users = @doctor.patfriends

    if params[:flag] == 'main'
      @pat = Patient.where(sql1).order("last_treat_time desc").paginate(:per_page => 10, :page => params[:page])
      # @cont_main_users.each do |user|
      #   if user.last_treat_time.nil?
      #     user.update(last_treat_time:Time.now)
      #   end
      #   user = {user:user,type:'主治患者'}.as_json
      #   @c_users.push(user)
      # end
    elsif params[:flag] == 'common'
      @pat = Patient.where(sql2).order("last_treat_time desc").paginate(:per_page => 10, :page => params[:page])
      # @cont_users.each do |user|
      #   if user.last_treat_time.nil?
      #     user.update(last_treat_time:Time.now)
      #   end
      #   user = {user:user,type:'普通患者'}.as_json
      #   @c_users.push(user)
      # end
    elsif params[:flag] == 'all'
      @pat =  Patient.where(sql3).order("last_treat_time desc").paginate(:per_page => 10, :page => params[:page])
      # @cont_main_users.each do |user|
      #   if user.last_treat_time.nil?
      #     user.update(last_treat_time:Time.now)
      #   end
      #   user = {user:user,type:'主治患者'}.as_json
      #   @c_users.push(user)
      # end
      # @cont_users.each do |user|
      #   if user.last_treat_time.nil?
      #     user.update(last_treat_time:Time.now)
      #   end
      #   user = {user:user,type:'普通患者'}.as_json
      #   @c_users.push(user)
      # end
    end
    # if !params[:first_name].nil? && params[:first_name] != '全部'
    #   @c_users.each do |user|
    #     if user.last_treat_time.nil?
    #       user.update(last_treat_time:Time.now)
    #     end
    #     if !/#{params[:first_name]}/.match(user['user']['spell_code'][0].upcase).nil?
    #       @users.push(user)
    #     end
    #   end
    # else
    #   @users = @c_users
    # end
    # @user = @users.sort{|p,q| p['user']['last_treat_time']<=>q['user']['last_treat_time']}.reverse
    @contact_users = @pat#@user.paginate(:per_page => 10, :page => params[:page])
    render partial: 'doctors/con_patients'
  end


  def play_video
    @title=params[:title]
    @video_url=params[:video_url]
    render 'doctors/play_video'
  end

  def more_video
    if params[:type_id].nil? || params[:type_id]==""
      params[:type_id]=nil
    end
    @type = VideoType.find_by(id:params[:type_id])
    if current_user.doctor.hospital_id.nil? || current_user.doctor.hospital_id == ''
      current_user.doctor.hospital_id = 0
    end
    if current_user.doctor.department_id.nil? || current_user.doctor.department_id == ''
      current_user.doctor.department_id = 0
    end
    sql = "video_type_id=#{params[:type_id]} and (view_permission = '公开' or (view_permission = '本医院' and hospital_id=#{current_user.doctor.hospital_id}) or ((view_permission = '本科室' or view_permission is null or view_permission = '') and department_id=#{current_user.doctor.department_id}))"
    @edu_videos = EduVideo.where(sql)

    render 'doctors/more_video'
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
    #@app_sch = AppointmentSchedule.where("schedule_date = ? and doctor_id = ?", params[:schedule_date],params[:doctor_id])
    #@app_arr = AppointmentArrange.where(:schedule_id => @app_sch,:status => 0)
    @app_arr = AppointmentArrange.where("schedule_date = ? and doctor_id = ?", params[:schedule_date],params[:doctor_id]).order("time_arrange")
    @app_arr.each do |app_arr|
      @appointment_schedule = app_arr.appointment_schedule
      start_time = @appointment_schedule.start_time
      end_time = @appointment_schedule.end_time
      date_cha = end_time - start_time
      step =  date_cha/ Integer(@appointment_schedule.avalailbecount)
      s_time = app_arr.time_arrange.to_time.strftime("%H:%M:%S")
      e_time = (s_time.to_time+Integer(step)).to_time.strftime("%H:%M:%S")
      @doc_arr = {arrange_id:app_arr.id.to_s,doctor_id:app_arr.doctor_id,start_time:s_time,end_time:e_time,schedule_date:app_arr.schedule_date}
      @doctor_arrs.push(@doc_arr)
    end
    render :json => {success:true,data:@doctor_arrs}
  end

  def get_doc_by_id
    @doctor = Doctor.find_by(id:params[:doctor_id])
    render json:{success:true,data:@doctor.as_json(
        :only => [:id,:name,:introduction,:professional_title,:photo]
    )}
  end


  # 修改医生信息
  def update_profile

  end
end
