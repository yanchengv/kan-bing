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
    p current_user
    p current_user.patient_id
    doc_id = current_user.doctor_id
    p doc_id.nil?


    @type = ''
    @reports = []
    patient_id = current_user.patient_id
    if !patient_id.nil?
      @patient = Patient.find(patient_id)

      #@patient = current_user['patient']
      #patient_id = @patient['id'].to_s
      us = []
      us << @patient.name
      createdAt = @patient.created_at.to_s
      date = createdAt[0,4]+','+createdAt[5,2].to_i.to_s
      us << date
      us << date.sub(',','-') + '-' + createdAt[8,2]
      @reports << us
      #根据数据库查询
      @inspection_reports = InspectionReport.where("patient_id = ?", patient_id)
      @inspection_reports.each do |r|
        res = []
        str = r.created_at.to_s
        date = str[0,4]+','+str[5,2].to_i.to_s
        thumbnail = r.thumbnail
        if r.child_type == 'ct'
          res << CTURL+thumbnail
        else
          res << "/dione/pdf_reports/show_picture?uuid="+thumbnail
        end
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end
      #根据inspection_reports查询
=begin
      url = CISURL + 'inspection_reports/?patientId='+patient_id
      uri = URI.parse(URI.encode(url.strip))
      reports_data = ''
      open(uri) do |http|
        reports_data=http.read
      end
      reports = JSON.parse(reports_data)
      reports.each do |r|
        res = []
        str = r['created_at']
        date = str[0,4]+','+str[5,2].to_i.to_s
        thumbnail = r['thumbnail']
        if r['child_type'] == 'ct'
          res << CTURL+thumbnail
        else
          res << "/dione/pdf_reports/show_picture?uuid="+thumbnail
        end
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end
=end

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