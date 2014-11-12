#encoding:utf-8
class HealthRecordsController < ApplicationController
  require 'open-uri'
  delegate "default_access_url_prefix_with", :to => "ActionController::Base.helpers"
  before_filter :signed_in_user
  skip_before_filter :verify_authenticity_token ,only:[:upload]
  #before_filter :user_health_record_power, only: [:ct,:ultrasound,:inspection_report]
  def play_video
    url = params[:video_url].split('.')[0]
    @video_url = Settings.edu_video + url[1,2] + '/' + url[4,2] + '/' + url[7,2] + '/' + url[10,30]
  end

  def go_where
    case params[:child_type]
      when 'CT'
        redirect_to '/health_records/ct?uuid='+params[:uuid]
      when '超声'
        redirect_to '/health_records/ultrasound?uuid='+params[:uuid]
      when '检验报告'
        redirect_to '/health_records/inspection_report?uuid='+params[:uuid]
      when '核磁'
        redirect_to '/health_records/mri?uuid='+params[:uuid]
      when '心电图'
        redirect_to '/ecg/show?ecg_id='+params[:uuid]
    end
  end

  def ct
    @obj ||= params[:uuid]
  end

  # 核磁
  def mri
    @obj ||= params[:uuid]
  end


  def ultrasound
    @uuid = params[:uuid]
    Aliyun::OSS::Base.establish_connection!(
        :server => 'oss.aliyuncs.com', #可不填,默认为此项
        :access_key_id => 'h17xgVZatOgQ6IeJ',
        :secret_access_key => '6RrQAXRaurcitBPzdQ18nrvEWjWuWO'
    )
    @flag = OSSObject.exists?(@uuid, 'mimas-open') #defaultbucket
    testmsg = ""
    xmlfile = replacewithsubfix(@uuid,"xml")
    pdffile = replacewithsubfix(@uuid,"pdf")

    #根据uuid 获取xml pdf
    #返回reportimage   Imagelist  videolist
    #if flag
    #
    #  xmlfile = "http://fit-ark.xicp.net:7500/files/109473c0c2a04c909f838fd6b71ddc96.xml"
    #  doc = Nokogiri::XML(open(xmlfile))
    #  st  =doc.xpath("//ImageList/de ")
    #  ar =st.attr('value').to_s
    #  @imagelist = ar.split(",")
    #else
    #end

    uuid = @uuid.split('.')[0]
    @uuid = uuid+'.png'
    @pic = []
    is_more = true
    num = 1
    @uuidObj = Uuid.new
    while is_more
      file_path = Settings.files_mount + 'png/' + @uuidObj.parse_uuid(uuid)+"_#{num}.png"
      if File.exist?(file_path)
        @pic << uuid+"_#{num}.png"
        num+=1
      else
        is_more = false
      end
    end
    @pics = @pic.join(',')
  end

  def inspection_report
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end

  def get_video
    send_data data.read, type: "application/x-shockwave-flash", disposition: "inline", stream: "true"
  end




  def get_data
    patient_id = session["patient_id"]
    irs = InspectionReport.where("patient_id = ?", patient_id).length
    cts = InspectionCt.where("patient_id = ?", patient_id).length
    ults = InspectionUltrasound.where("patient_id = ?", patient_id).length
    nms = InspectionNuclearMagnetic.where("patient_id = ?", patient_id).length
    inds = InspectionData.where("patient_id = ?", patient_id).length
    data = {
        "ct" => cts,
        "ult" => ults,
        "nm" => nms,
        "dicom" => cts+ults+nms,
        "ins_report" => inds,
        "ins" => inds,
        "all" => irs
    }
    render json: {data: data}
  end

  def dicom
    @irs = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def inspection
    @irs = InspectionReport.
        where("patient_id = ? and (child_type = ? or child_type = ? or child_type = ?)",session["patient_id"],'CT','超声','核磁',).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def ct2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'CT').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionCt.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ct'
  end
   def mri2
     #@irs = InspectionReport.
     #    where("patient_id = ? and child_type = ? ",session["patient_id"],'核磁').
     #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
     @irs = InspectionNuclearMagnetic.
         where("patient_id = ?",session["patient_id"]).
         paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
     render partial: 'health_records/mri'
   end

  def ultrasound2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'超声').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionUltrasound.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ultrasound'
  end

  def inspection_report2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'检验报告').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionData.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/inspection_report'
  end

  def undefined_other
    render partial: 'health_records/undefined_other'
  end

  def upload
    b = false
    archive_type = params[:archivetype]
    stamp = DateTime.parse(Time.now.to_s).strftime("%T")
    upload_path = "uploads/cts/" << Date.today.to_s
    target_dir = Rails.root.join('public', upload_path)
    FileUtils.mkdir_p(target_dir)

    if !params[:fileToUpload].nil?
      if current_user.patient_id.nil?  && (!current_user.doctor_id.nil?)
        pat_id = params[:id]
        udoctor = current_user.doctor
      elsif
      pat_id = current_user.patient_id
        udoctor = current_user.patient.doctor
      end
      patient_name =  Patient.exists?(pat_id)?  Patient.find(pat_id).name: "patient"
      uploaded_io = params[:fileToUpload]
      filename1 = uploaded_io.original_filename
      filename = stamp << "-" << patient_name << "-" << filename1
      begin
        File.open(Rails.root.join('public', upload_path, filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        b = true

        if !udoctor.nil?
          doctor = udoctor.name
          department = udoctor.department.name
          hospital = udoctor.department.hospital.name
          inspectReport = InspectionCt.new(
              :patient_id => pat_id,
              :parent_type => "影像信息",
              :child_type => archive_type,
              :doctor => doctor,
              :hospital => hospital,
              :department => department,
              :upload_doctor_id => current_user.id,
              :upload_doctor_name => current_user.name,
              :checked_at => Date.today.to_s
          );

          if inspectReport.save
            ArchiveQueue.create(
                :user_id => current_user.id,
                :user_name => current_user.name,
                :uploadfile_type => archive_type,
                :filename => upload_path << "/"<< filename,
                :filesize => uploaded_io.size,
                :extname => File.extname("filename"),
                :table_name => "inspection_cts",
                :pk => inspectReport.id,
                :status => 1)
          end

        end

      rescue StandardError => e
        puts e
      ensure
        tempfile = uploaded_io.tempfile.path
        #p  "tmp file path is :"  <<  tempfile << "file exits? " << File.exists?(tempfile).to_s
        if File.exists?(tempfile)
          File.delete(tempfile)
        end
      end

    end

    if b
      render :text => ({:success => "文件上传成功", data: true}.to_json)
    else
      render :text => ({:error => "文件类型错误或者存在异常", data: false}.to_json)
    end

  end

  private
  #判断有无权限读取某一患者的超声报告
  def user_health_record_power
    @ips = InspectionReport.where('thumbnail=?',params[:uuid])
    is_equal = false
    unless @ips.empty?
      @ip = @ips.first
      if !current_user.patient_id.nil?
        is_equal = true if current_user.patient_id == @ip.patient_id
      else !current_user.doctor_id.nil?
        is_equal = true if (!Patient.where('id=? and doctor_id=?',@ip.patient_id,current_user.doctor_id).empty? || !TreatmentRelationship.where('doctor_id=? and patient_id=?',current_user.doctor_id,@ip.patient_id).empty?)
      end
    end
    redirect_to '/' unless is_equal
  end
end
