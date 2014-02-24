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
    render partial:'health_records/blood_pressure'
  end
  def ct2
    u = user_type
    user = u[0].constantize.find(u[1])
    @name = user.name
    url = Settings.ct + "dcm4chee-arc/rs/qido/DCM4CHEE/studies?PatientID=133101"
    reports = get_dicom_by_uri(url)
    @studyUID = []
    reports.each do |rs|
      @arr = []
      @arr << rs["StudyInstanceUID"]["Value"][0]
      @arr << rs["ModalitiesInStudy"]["Value"][0]
      @arr << rs["StudyDate"]["Value"][0]
      @studyUID << @arr
    end
    render partial:'health_records/ct'
  end
  def ultrasound2
    u = user_type
    user = u[0].constantize.find(u[1])
    @name = user.name
    @us_reports = UsReport.where('patient_id=?',u[1])
    @reports = []
    @us_reports.each do |r|
      @arr = []
      @arr << ExaminedItem.find(r.examined_item_id).item
      @arr << ExaminedPosition.find(r.examined_part_id).position
      @arr << Doctor.find(r.examine_doctor_id).name
      @arr << r.initial_diagnosis
      @arr << r.check_start_time
      @arr << r.report_document_id
      @reports << @arr
    end
    render partial:'health_records/ultrasound'
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
    open(uri,"Accept"=>"application/json") do |http|
      reports_data = http.read
    end

    if reports_data==""
      nil
    else
      JSON.parse(reports_data)
    end
  end
end
