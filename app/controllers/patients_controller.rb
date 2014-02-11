#encoding:utf-8
class PatientsController < ApplicationController
  before_filter :signed_in_user
  def get_aspects
    @user = User.new
    param = {'remember_token' => current_user['remember_token']}
    @trfriends = @user.post_req('trfriends.json',param)
    if @trfriends['success']
      @cont_doctors = @trfriends['data']
    else
      @cont_doctors = ''
    end
    @maindoc = @user.post_req('maindoc.json',param)
    if @maindoc['success']
      @contact_main_doctors = @user.post_req('maindoc.json',param)['data']
    else
      @contact_main_doctors = ''
    end
    @contact_doctors = []
    if @cont_doctors.length > 9
      i = 0
      while i<9
        @contact_doctors.push(@cont_doctors[i])
        i=i+1
      end
    else
      @contact_doctors = @cont_doctors
    end
    #@friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+current_user['patient_id'].to_s)['data']
    #@contact_doctors = @friend['docfriends']
    #@contact_main_doctors=@friend['doctor']
    render partial: 'patients/patient_home_aspects'
  end

  def patient_page
    @user = User.new
    @patient_id = params[:id]
    param = {'patient_id' => params[:id], 'currentuserid' => current_user['id'],'remember_token' => current_user['remember_token']}
    is_friends = @user.post_req('patients/is_friends',param)['success']
    if !current_user['doctor_id'].nil? && is_friends
      @patient1 = @user.get_req('patients/find_patient?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
      #@friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
      #@cont_doctors = @friend['docfriends']
      #@contact_main_doctors1=@friend['doctor']
      #@contact_doctors1 = []
      #if @cont_doctors.length > 9
      #  i = 0
      #  while i<9
      #    @contact_doctors1.push(@cont_doctors[i])
      #    i=i+1
      #  end
      #else
      #  @contact_doctors1 = @cont_doctors
      #end
      @is_friends = is_friends
    else
      flash[:success] = "您没有访问该用户信息的权限"
      redirect_to root_path
    end
  end

  def friends
    @user = User.new
    @current_page=params[:page]
    @patient_id = params[:id]
    param = {'patient_id' => params[:id],'page' => params[:page],'remember_token' => current_user['remember_token']}
    #@friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
    @friend=@user.post_req('treatment_relationships/getfriends3',param)['data']
    @cont_doctors = @friend['docfriends']
    @docf_count = @friend['docf_count']
    if @docf_count.to_i%5==0
      @count = @docf_count.to_i/5
    else
      @count = @docf_count.to_i/5+1
    end
    type=params["type"]
    if type=="1"
      if !@cont_doctors.nil?
        @contact_doctors=@cont_doctors
      end
      @title="医生列表"
    end
    render :template => 'patients/all_friends'
  end

  def change_main_doctor
    @user = User.new
    @current_page=params[:page]
    @doc_users=@user.get_req('doctors/find_all_doctor2?remember_token='+current_user['remember_token'])['data']
    if @doc_users.count.to_i%5 == 0
      @doc_count = @doc_users.count.to_i/5
    else
      @doc_count = @doc_users.count.to_i/5+1
    end
    if params[:page].nil?
      params[:page] = 1
    end
    page = params[:page].to_i
    per_page = 5
    @doctor_users = []
    i = 0
    while i<per_page
      num = (page-1)*per_page+i
      if num < @doc_users.count.to_i
        @doctor_users.push(@doc_users[num])
        i=i+1
      else
        break
      end
    end
    render :template => "patients/change_main_doctor"
  end

end
