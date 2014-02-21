#encoding:utf-8
require 'open-uri'
class NavigationsController < ApplicationController
  def signed_mini
    user = User.find_by(name: [params[:session][:name]])
    if user && user.authenticate(params[:session][:password])

      sign_in user
      if params[:flag]=='1'
        render :template =>  'health_records/index'
      elsif params[:flag]=='2'
        render :template => 'consultations/index'
      elsif params[:flag]=='3'
        redirect_to  '/appointments/myappointment'
      end
    else
        flash[:success] = '登录失败！'
        redirect_to  '/'
    end
  end
  def navigation_health_record
    render :template =>  'health_records/index'
  end
  def remote_consultation
    if signed_in?
      @my_consultations = current_user.managed_cons
      @joined_consultations = current_user.joined_cons
      @cons_record = @my_consultations.concat(@joined_consultations)
      @cons_record.sort_by {|u| u.created_at}
      @applied_consultations = current_user.applied_cons
      @invited_master_consultations = current_user.invited_master_cons
      @invited_consultations = current_user.invited_cons
      @invited_consultations.sort_by {|u| u.created_at}
      render :template => 'navigations/remote_consultation'
    else
      redirect_to root_path
    end
    store_location
  end

end