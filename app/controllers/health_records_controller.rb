#encoding:utf-8
require 'open-uri'
class HealthRecordsController < ApplicationController
  before_filter :signed_in_user
  def play_video
    url = params[:video_url].split('.')[0]
    @video_url = 'rtmp://' + Settings.videoServerIp + '/vod/' + url[1,2] + '/' + url[4,2] + '/' + url[7,2] + '/' + url[10,30]
    p @video_url
  end

  def go_where
    case params[:child_type]
      when 'CT'
        redirect_to '/health_records/ct'
      when '超声'
        redirect_to '/health_records/ultrasound?uuid='+params[:uuid]
      when '检验报告'
        redirect_to '/health_records/inspection_report?uuid='+params[:uuid]
    end
  end

  def ct
    #@studyUID = params[:studyUID]
    #url = Settings.ct + 'dcm4chee-arc/rs/qido/DCM4CHEE/studies?PatientID=133101'
    #arr = get_dicom_by_uri(url)
    #@studyUID = arr[0]["StudyInstanceUID"]["Value"][0]
    @obj = ''
    if PacsPatient.where('pat_id = ?','133101').length != 0
      PacsPatient.where('pat_id = ?','133101').first.pacs_studies.first.pacs_serieses.first.pacs_instances.each do |instance|
        @obj += ',' + Settings.pacs_directory + instance.pacs_file_refs.first.filepath
      end
    end
    @obj = @obj.sub(',','')
  end

  def ultrasound
    @ip = Settings.video_ip
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end

  def inspection_report
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end

  def get_video
    data = open(Settings.video_palyer+'player.swf')
    send_data data.read, type: "application/x-shockwave-flash", disposition: "inline", stream: "true"
  end


  def blood_pressure
    render partial: 'health_records/blood_pressure'
  end

  def get_data
    @irs = InspectionReport.where("patient_id = ?", session["patient_id"])
    ct = 0
    ult = 0
    ins_report = 0
    @irs.each do |i|
      case i.child_type
        when 'CT'
          ct += 1
          next
        when '超声'
          ult += 1
          next
        when '检验报告'
          ins_report += 1
          next
      end
    end
    dicom = ct + ult
    ins = ins_report
    data = {
        "ct" => ct,
        "ult" => ult,
        "dicom" => dicom,
        "ins_report" => ins_report,
        "ins" => ins
    }
    render json: {data: data}
  end

  def dicom
    @irs = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def ct2
    @irs = InspectionReport.
        where("patient_id = ? and child_type = ? ",session["patient_id"],'CT').
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ct'
  end

  def ultrasound2
    @irs = InspectionReport.
        where("patient_id = ? and child_type = ? ",session["patient_id"],'超声').
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ultrasound'
  end

  def inspection_report2
    @irs = InspectionReport.
        where("patient_id = ? and child_type = ? ",session["patient_id"],'检验报告').
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/inspection_report'
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
