#encoding: utf-8
class MobileTerminalController < ApplicationController
  include Aliyun::OSS
  require 'aliyun/oss'
  require 'open-uri'
  def baby_reports
    user_id ||= params[:user_id]
    @user = User.find_by_id(user_id)
    patientId = @user.patient_id if @user
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 1)
      @baby_reports.each do |b|
        reports = {}
        reports['date'] = b.appointment_time.strftime("%Y-%m-%d")
        reports['department'] = b.apply_department_name
        reports['doctor'] = b.examine_doctor_name
        reports['item'] = b.examined_item_name
        reports['hospital'] = b.hospital_name
        reports['uuid'] = b.report_document_id
        res << reports
      end
    end
    render json: {result: res}
  end

  def baby_pictures
    user_id ||= params[:user_id]
    @user = User.find_by_id(user_id)
    patientId = @user.patient_id if @user
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 1)
      @baby_reports.each do |b|
        pictures = {}
        pictures['date'] = b.appointment_time.strftime("%Y-%m-%d")
        uuid = b.report_document_id
        if params[:version]=="4.2"
          pictures['pictures'] = uuid.nil?||uuid=='' ? [] : get_pictures_by_aliyun(uuid)
        else
          pictures['pictures'] = uuid.nil?||uuid=='' ? [] : get_pictures(uuid)
        end
        #pictures['pictures'] = uuid.nil?||uuid=='' ? [] : get_pictures(uuid)
        pictures['uuid'] = b.report_document_id
        res << pictures
      end
    end
    render json: {result: res}
  end

  def baby_videos
    user_id ||= params[:user_id]
    @user = User.find_by_id(user_id)
    patientId = @user.patient_id if @user
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 1)
      @baby_reports.each do |b|
        videos = {}
        resources = []
        videos['date'] = b.appointment_time.strftime("%Y-%m-%d")
        uuid = b.report_document_id
        if params[:version]=="4.2"
          videos['videos'] = uuid.nil?||uuid=='' ? [] : get_videos_by_aliyun(uuid)
        else
          videos['videos'] = uuid.nil?||uuid=='' ? [] : get_videos(uuid)
        end

        videos['uuid'] = b.report_document_id
        res << videos
      end
    end
    render json: {result: res}
  end
  def baby_ultrasounds
    user_id ||= params[:user_id]
    version ||= params[:version]
    @user = User.find_by_id(user_id)
    patientId = @user.patient_id if @user
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 1)
      @baby_reports.each do |b|
        ultrasounds = {}
        ultrasounds['date'] = b.appointment_time.strftime("%Y-%m-%d")
        ultrasounds['department'] = b.apply_department_name
        ultrasounds['doctor'] = b.examine_doctor_name
        ultrasounds['item'] = b.examined_item_name
        ultrasounds['hospital'] = b.hospital_name
        uuid = b.report_document_id
        ultrasounds['uuid'] = uuid
        if version=="4.2"
          ultrasounds['pictures'] = uuid.nil?||uuid=='' ? [] : get_pictures_by_aliyun(uuid)
          ultrasounds['videos'] = uuid.nil?||uuid=='' ? [] : get_videos_by_aliyun(uuid)
        else
          ultrasounds['pictures'] = uuid.nil?||uuid=='' ? [] : get_pictures(uuid)
          ultrasounds['videos'] = uuid.nil?||uuid=='' ? [] : get_videos(uuid)
        end
        res << ultrasounds
      end
    end
    render json: {result: res}
  end

  private
  def get_pictures(uuid)
    pics = []
    @uuid = Uuid.new
    @mt = MobileTerminal.new
    uuid = uuid.split('.').first+'.xml'
    uuid_path = @uuid.parse_uuid(uuid)
    path = Settings.xml_path+uuid_path
    report_xml = Nokogiri::XML.parse(File.read(path), path)
    @emrDocument = report_xml.xpath("//EMRDocument")
    @emrDocument.xpath('dg').each do |dg|
      dg_name = dg.attr('name')
      if dg_name == '图片'
        de = @emrDocument.xpath("dg[@name='图片']").xpath("de")
        images = de.attribute('value').text
        if !images.nil? && images != ''
          pics = pics | @mt.exist_resources(images)
        end
      end
    end
    imgs = @emrDocument.xpath("ImageList/de").attribute("value").text
    if !imgs.nil? && imgs != ''
      pics = pics | @mt.exist_resources(imgs)
    end
    pics
  end
  def get_videos(uuid)
    resources,videos = [],[]
    @uuid = Uuid.new
    @mt = MobileTerminal.new
    uuid_path = @uuid.parse_uuid(uuid)
    path = Settings.xml_path+uuid_path
    report_xml = Nokogiri::XML.parse(File.read(path), path)
    @emrDocument = report_xml.xpath("//EMRDocument")
    resource = @emrDocument.xpath("VideoList/de").attribute("value").text
    if !resource.nil? && resource != ''
      resources = @mt.exist_resources(resource)
    end
    resources.each do |r|
      videos << {video: r,video_thumbail: r.sub('.flv','.jpg')}
    end
    videos
  end
  def get_pictures_by_aliyun(uuid)
    #uuid = "08ed549c4ba640239e191c9de0c09013.xml"
    beijing_aliyun_connection
    pics = []
    xml_bucket = Settings.aliyunOSS.xml_bucket
    if OSSObject.exists? uuid, xml_bucket
      report_xml = Nokogiri::XML(open("http://#{Settings.aliyunOSS.xml_bucket}.#{Settings.aliyunOSS.beijing_server}/#{uuid}"))
      @emrDocument = report_xml.xpath("//EMRDocument")
      @emrDocument.xpath('dg').each do |dg|
        dg_name = dg.attr('name')
        if dg_name == '图片'
          de = @emrDocument.xpath("dg[@name='图片']").xpath("de")
          images = de.attribute('value').text
          if !images.nil? && images != ''
            pics = pics | pictures_exist(images)
          end
        end
      end
      imgs = @emrDocument.xpath("ImageList/de").attribute("value").text
      if !imgs.nil? && imgs != ''
        pics = pics | pictures_exist(imgs)
      end
    end
    pics
  end
  def get_videos_by_aliyun(uuid)
    #uuid = "08ed549c4ba640239e191c9de0c09013.xml"
    beijing_aliyun_connection
    videos = []
    xml_bucket = Settings.aliyunOSS.xml_bucket
    if OSSObject.exists? uuid, xml_bucket
      report_xml = Nokogiri::XML(open("http://#{Settings.aliyunOSS.xml_bucket}.#{Settings.aliyunOSS.beijing_server}/#{uuid}"))
      @emrDocument = report_xml.xpath("//EMRDocument")
      resource = @emrDocument.xpath("VideoList/de").attribute("value").text
      if !resource.nil? && resource != ''
        resources = videos_exist(resource)
      end
      resources.each do |r|
        if (res=pictures_exist(r.split("/").last)).length == 1
          videos << {video: r,video_thumbail: res.first}
        else
          videos << {video: r,video_thumbail: ""}
        end

      end
    end
    videos
  end
  def beijing_aliyun_connection
    Aliyun::OSS::Base.establish_connection!(
        :server => Settings.aliyunOSS.beijing_server, #可不填,默认为此项
        :access_key_id => Settings.aliyunOSS.access_key_id,
        :secret_access_key => Settings.aliyunOSS.secret_access_key
    )
  end
  def hangzhou_aliyun_connection
    Aliyun::OSS::Base.establish_connection!(
        :server => Settings.aliyunOSS.server, #可不填,默认为此项
        :access_key_id => Settings.aliyunOSS.access_key_id,
        :secret_access_key => Settings.aliyunOSS.secret_access_key
    )
  end
  def pictures_exist(resource)
    hangzhou_aliyun_connection
    resources = resource.split(',')
    resource_group = []
    resources.each do |i|
      #i = "021308fdc4bd45df9a3d168e9120c2ee.jpg"
      if OSSObject.exists? i, Settings.aliyunOSS.default_bucket
        resource_group = resource_group | ["http://#{Settings.aliyunOSS.default_bucket}.#{Settings.aliyunOSS.server}/#{i}"]
      end
    end
    resource_group
  end
  def videos_exist(resource)
    beijing_aliyun_connection
    resources = resource.split(',')
    resource_group = []
    resources.each do |i|
      #i = "0b74ec223872412c8b35fd830bdfc531.flv"
      if OSSObject.exists? i, Settings.aliyunOSS.video_bucket
        resource_group = resource_group | ["http://#{Settings.aliyunOSS.video_bucket}.#{Settings.aliyunOSS.beijing_server}/#{i}"]
      end
    end
    resource_group
  end
end
