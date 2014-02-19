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
    @type = ''
    @reports = []
    patient_id = current_user.patient_id
    if !patient_id.nil?
      @patient = Patient.find(patient_id)
      us = []
      us << @patient.name
      createdAt = @patient.birthday.to_s
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
        #if r.child_type == 'ct'
        #  res << CTURL+thumbnail
        #else
        res << "/dione/pdf_reports/show_picture?uuid="+thumbnail
        #end
        res << date
        res << date.sub(',','-') + '-' + str[8,2]
        @reports << res
      end
      #根据患者ID 查询studyUID
      url = CTURL + "dcm4chee-arc/rs/qido/DCM4CHEE/studies?PatientID=133101"
      reports = get_data_by_uri(url,"Accept"=>"application/json")
      @studyUID = []
      if reports.nil?

      else
        reports.each do |rs|
          study = []
          studyUID = rs["StudyInstanceUID"]["Value"][0]
          dateValue = rs["StudyDate"]["Value"][0]
          seriesUrl = CTURL + 'dcm4chee-arc/rs/qido/DCM4CHEE/studies/'+studyUID+'/series'
          series_results = get_data_by_uri(seriesUrl,"Accept"=>"application/json")
          seriesUID = series_results[0]["SeriesInstanceUID"]["Value"][0]
          instance_url = CTURL + 'dcm4chee-arc/rs/qido/DCM4CHEE/studies/'+studyUID+'/series/'+seriesUID+'/instances'
          instance_results = get_data_by_uri(instance_url,"Accept"=>"application/json")
          objectUID = instance_results.last["SOPInstanceUID"]["Value"][0]
          ct_thumbnail = CTURL+'dcm4chee-arc/rs/wado/DCM4CHEE?requestType=WADO&studyUID='+studyUID+'&seriesUID='+seriesUID+'&objectUID='+objectUID
          sDate = dateValue[0,4]+','+dateValue[4,2]
          study << sDate
          study << sDate.sub(',','-')+'-'+dateValue[6,2]
          study << ct_thumbnail
          @studyUID << study
        end
      end
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

  public
  def get_data_by_uri(url,head)
    uri = URI.parse(URI.encode(url.strip))
    reports_data = ''
    open(uri,head) do |http|
      reports_data = http.read
    end

    if reports_data==""
      nil
    else
      JSON.parse(reports_data)
    end
  end
end