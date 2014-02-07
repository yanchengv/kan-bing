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
    @type = ''
    @reports = []
    if !current_user['patient'].nil?
      @patient = current_user['patient']
      patient_id = @patient['id'].to_s
      us = []
      us << @patient['name']
      createdAt = @patient['created_at']
      date = createdAt[0,4]+','+createdAt[5,2].to_i.to_s
      us << date
      us << date.sub(',','-') + '-' + createdAt[8,2]
      @reports << us

      #根据inspection_reports查询
      url = CISURL + 'inspection_reports/?patientId='+patient_id
      uri = URI.parse(URI.encode(url.strip))
      reports_data = ''
      open(uri) do |http|
        reports_data=http.read
      end
      reports = JSON.parse(reports_data)
      reports.each do |r|
        res = []
        str = r['createdAt']
        date = str[0,4]+','+str[5,2].to_i.to_s
        thumbnail = r['thumbnail']
        if r['childType'] == 'ct'
          res << CTURL+thumbnail
        else
          res << "/dione/pdf_reports/show_picture?uuid="+thumbnail
        end
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end

      #根据us_reports查询
=begin
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
        #res << FILESURL + r['report_document_id']
        res << r['report_document_id']
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end
=end
      @type = 'patient'
    else

    end
    render :template =>  'health_records/index'
  end
  def remote_consultation
    render :template => 'consultations/index'
  end
end