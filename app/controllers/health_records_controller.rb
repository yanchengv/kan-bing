require 'open-uri'
class HealthRecordsController < ApplicationController
  def ct
    @studyUID = params[:studyUID]
  end

  def ultrasound
    @ip = Settings.video_ip
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end

  def get_video
    data = open(Setting.video_palyer+'player.swf')
    send_data data.read, type: "application/x-shockwave-flash", disposition: "inline", stream: "true"
  end


  def blood_pressure
    render partial: 'health_records/blood_pressure'
  end

  def dicom
    @irs = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 14, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def ct2
    @irs = InspectionReport.
        where("patient_id = ? and child_type = ? ",session["patient_id"],'CT').
        paginate(:per_page => 14, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ct'
  end

  def ultrasound2
    @irs = InspectionReport.
        where("patient_id = ? and child_type = ? ",session["patient_id"],'超声').
        paginate(:per_page => 14, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ultrasound'
  end

  #判断用户类型 patient nurse doctor
  def user_type
    user = []
    patID = current_user.patient_id
    docID = current_user.doctor_id
    nurID = current_user.nurse_id
    if !patID.nil?
      user << 'Patient'
      user << patID
    elsif !docID.nil?
      user << 'Doctor'
      user << docID
    elsif !nurID.nil?
      user << 'Nurse'
      user << nurID
    end
    user
  end

  #查询dicom影像的studyUID
  def get_dicom_by_uri(url)
    uri = URI.parse(URI.encode(url.strip))
    reports_data = ''
    open(uri, "Accept" => "application/json") do |http|
      reports_data = http.read
    end

    if reports_data==""
      nil
    else
      JSON.parse(reports_data)
    end
  end
end
