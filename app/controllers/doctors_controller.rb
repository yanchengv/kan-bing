#encoding:utf-8
#require 'will_paginate/array'
class DoctorsController < ApplicationController
  before_filter :signed_in_user ,only:[:get_aspects,:doctor_page,:friends]

  #首页面医生显示
  def index_doctors_list
    @user = User.new
    @doctors_all = @user.get_req('doctors/find_all_doctor')['data']
    @num = @doctors_all.length
    @doctor = @doctors_all[0]
    @image_url = PICURL
    render partial: 'doctors/index_doctors_list'
  end

  def get_aspects
    @user = User.new
    param = {'remember_token' => current_user['remember_token']}
    @friend = @user.post_req('trfriends.json',param)['data']
    @cont_users = @friend['patf']
    @cont_main_users = @friend['mainpat']
    @cont_doctors = @user.get_req('doctor_friendships?remember_token='+current_user['remember_token'])
    @contact_users = []
    @contact_main_users = []
    @contact_doctors = []
    if @cont_users.length > 9
      i = 0
      while i<9
        @contact_users.push(@cont_users[i])
        i=i+1
      end
    else
      @contact_users = @cont_users
    end
    if @cont_main_users.length > 6
      i = 0
      while i<6
        @contact_main_users.push(@cont_main_users[i])
        i=i+1
      end
    else
      @contact_main_users = @cont_main_users
    end
    if @cont_doctors.length > 6
      i = 0
      while i<6
        @contact_doctors.push(@cont_doctors[i])
        i=i+1
      end
    else
      @contact_doctors = @cont_doctors
    end
    #@friend=@user.get_req('treatment_relationships/getfriends2?doctor_id='+current_user['doctor_id'].to_s)['data']
    #@contact_users = @friend['patfriends']
    #@contact_main_users=@friend['patients']
    #@contact_doctors=@user.get_req('doctor_friendships/find_friends?doctor_id='+current_user['id'].to_s)
    render partial: 'doctors/doctor_home_aspects'
  end

  def doctor_page
    #if params[:id].to_i == current_user['doctor_id'].to_i
    #  redirect_to '/home'
    #end
    @user = User.new
    @doctor_id = params[:id]
    param = {'currentuserid' => current_user['id'],'doctor_id' => params[:id],'remember_token' => current_user['remember_token']}
    is_friends = @user.post_req('doctors/is_friends',param)['success']
    @doctor1 = @user.get_req('doctors/find_doctor?doctor_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
    @friend=@user.get_req('treatment_relationships/getfriends2?doctor_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
    @cont_users = @friend['patfriends']
    @cont_main_users=@friend['patients']
    @cont_doctors=@user.get_req('doctor_friendships/find_friends?doctor_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])
    @contact_users1 = []
    @contact_main_users1 = []
    @contact_doctors1 = []
    if @cont_users.length > 9
      i = 0
      while i<9
        @contact_users1.push(@cont_users[i])
        i=i+1
      end
    else
      @contact_users1 = @cont_users
    end
    if @cont_main_users.length > 6
      i = 0
      while i<6
        @contact_main_users1.push(@cont_main_users[i])
        i=i+1
      end
    else
      @contact_main_users1 = @cont_main_users
    end
    if @cont_doctors.length > 6
      i = 0
      while i<6
        @contact_doctors1.push(@cont_doctors[i])
        i=i+1
      end
    else
      @contact_doctors1 = @cont_doctors
    end
    @is_friends = is_friends
    #显示医生预约
    @duplicateAppointAvalibles  = @user.get_req('appointment_avalibles/get_avalibles?doctorId='+params[:id].to_s+'&remember_token='+current_user['remember_token'])
  end

  def friends
    @user = User.new
    @doctor_id = params[:id]
    @current_page = params[:page]
    param = {'doctor_id' => params[:id],'page' => params[:page],'remember_token' => current_user['remember_token']}
    #@friend=@user.get_req('treatment_relationships/getfriends2?doctor_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
    @friend = @user.post_req('treatment_relationships/getfriends3',param)['data']
    @cont_users = @friend['patfriends']
    @patf_count = @friend['patf_count']
    puts @patf_count
    if @patf_count.to_i%5==0
      @count3 = @patf_count.to_i/5
    else
      @count3 = @patf_count.to_i/5+1
    end
    @cont_main_users=@friend['patients']
    @pati_count = @friend['pati_count']
    if @pati_count.to_i%5==0
      @count2 = @pati_count.to_i/5
    else
      @count2 = @pati_count.to_i/5+1
    end
    #@cont_doctors=@user.get_req('doctor_friendships/find_friends?doctor_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])
    @doc_fri= @user.post_req('doctor_friendships/find_friends2',param)
    @cont_doctors = @doc_fri['friends']
    @fri_count = @doc_fri['fri_count']
    if @fri_count.to_i%5==0
      @count1 = @fri_count.to_i/5
    else
      @count1 = @fri_count.to_i/5+1
    end
    @type = params["type"]
    type=params["type"]
    if type=="1"
      if !@cont_doctors.empty?
        @contact_doctors2=@cont_doctors#.paginate(:per_page =>5,:page => params[:page])
      end
      @title="好友列表"
    elsif type=="2"
      if !@cont_main_users.empty?
        @contact_main_users2=@cont_main_users#.paginate(:per_page =>5,:page => params[:page])
      end
      @title="主治患者列表"
    else type=="3"
    if !@cont_users.empty?
      @contact_users2=@cont_users#.paginate(:per_page =>5,:page => params[:page])
    end
    @title="患者列表"
    end
    render :template => 'doctors/all_friends'
  end
end
