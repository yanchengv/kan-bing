#encoding:utf-8
require 'open-uri'
class NavigationsController < ApplicationController
  def signed_mini
    login_name = params[:session][:username]
    password = params[:session][:password]
    param = {'username' => login_name,'password' => password}
    if !login_name.nil? && !password.nil? && login_name!='' && password!=''
      path = 'sessions/login_in'
      @user = User.new
      @search_result = @user.post_req(path,param)
      if @search_result['success']
        cookies.permanent[:remember_token] = @search_result['data']['remember_token']
        self.current_user = @search_result['data']
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
    else
      flash[:success] = '登录失败！'
      redirect_to  '/'
    end
  end
  def navigation_health_record
    id = current_user['id'].to_s
    url= CISURL + 'users/'+id
    response_data=nil
    uri = URI.parse(URI.encode(url.strip))
    open(uri) do |http|
      response_data=http.read
    end
    res_data = JSON.parse(response_data)
    @type = ''
    @reports = []
    if !res_data['patient_id'].nil?
      patient_id = res_data['patient_id'].to_s
      url = CISURL + 'patients/'+patient_id
      uri = URI.parse(URI.encode(url.strip))
      reports_data = ''
      open(uri) do |http|
        reports_data=http.read
      end
      reports = JSON.parse(reports_data)
      us = []
      us << reports['name']
      createdAt = reports['created_at']
      date = createdAt[0,4]+','+createdAt[5,2].to_i.to_s
      us << date
      us << date.sub(',','-') + '-' + createdAt[8,2]
      @reports << us
      url = CISURL + 'us_reports/?[us_report][patient_id]='+patient_id
      uri = URI.parse(URI.encode(url.strip))
      reports_data = ''
      open(uri) do |http|
        reports_data=http.read
      end
      reports = JSON.parse(reports_data)
      reports['us_reports'].each do |r|
        res = []
        str = r['created_at']
        date = str[0,4]+','+str[5,2].to_i.to_s
        res << FILESURL + r['report_document_id']
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end
      #以下@reports为测试
      #@reports = [['http://ww2.sinaimg.cn/bmiddle/62c13fbajw1ecaqy3967aj20c72ghtsl.jpg','2014,1,6'],['http://166.111.138.139:7500/files/ed1fdb5c878f4033877d6b1608ab7d39.jpg','2014,8']]
      @type = 'patient'
    elsif !res_data['doctor_id'].nil?

    else !res_data['nurse_id'].nil?

    end
    render :template =>  'health_records/index'
  end
  def remote_consultation
    render :template => 'consultations/index'
  end
end
