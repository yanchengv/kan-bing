#encoding:utf-8
class PatientsController < ApplicationController
  before_filter :signed_in_user
  def get_aspects
    @user = User.new
    param = {'remember_token' => current_user['remember_token']}
    @contact_doctors = @user.post_req('trfriends.json',param)['data']
    @contact_main_doctors = @user.post_req('maindoc.json',param)['data']
    #@friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+current_user['patient_id'].to_s)['data']
    #@contact_doctors = @friend['docfriends']
    #@contact_main_doctors=@friend['doctor']
    render partial: 'patients/patient_home_aspects'
  end

  def patient_page
    if params[:id] == current_user['patient_id']
      redirect_to '/home'
    end
    @user = User.new
    @patient_id = params[:id]
    param = {'patient_id' => params[:id], 'currentuserid' => current_user['id'],'remember_token' => current_user['remember_token']}
    is_friends = @user.post_req('patients/is_friends',param)['success']
    if !current_user['doctor_id'].nil?
      @patient1 = @user.get_req('patients/find_patient?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
      @friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
      @contact_doctors1 = @friend['docfriends']
      @contact_main_doctors1=@friend['doctor']
      @is_friends = is_friends
    else
      flash[:success] = "您没有访问该用户信息的权限"
      redirect_to :back
    end
  end

  def friends
    @user = User.new
    @friend=@user.get_req('treatment_relationships/getfriends2?patient_id='+params[:id].to_s+'&remember_token='+current_user['remember_token'])['data']
    @cont_doctors = @friend['docfriends']
    type=params["type"]
    if type=="1"
      if !@cont_doctors.nil?
        @contact_doctors=@cont_doctors#.paginate(:per_page =>5,:page => params[:page])
      end
      @title="医生列表"
    end
    render :template => 'patients/all_friends'
  end

  def change_main_doctor
    @user = User.new
    @doctor_users=@user.get_req('doctors/find_all_doctor2?remember_token='+current_user['remember_token'])['data']
    render :template => "patients/change_main_doctor"
  end

end
