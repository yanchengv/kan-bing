#encoding: utf-8
class MobileTerminalController < ApplicationController
  def baby_reports
    user_id ||= params[:user_id]
    @user = User.find_by_id(user_id)
    patientId = @user.patient_id if @user
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 'babyReports')
      @baby_reports.each do |b|
        reports = {}
        reports['date'] = b.appointment_time
        reports['department'] = b.apply_department_name
        reports['doctor'] = b.examine_doctor_name
        reports['item'] = b.examined_item_name
        reports['hospital'] = '清华大学玉泉医院'
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
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 'babyReports')
      @baby_reports.each do |b|
        pictures = {}
        pics = []
        pictures['date'] = b.appointment_time
        uuid = b.report_document_id
        if !uuid.nil? && uuid!=''
          @uuid = Uuid.new
          @mt = MobileTerminal.new
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
        end
        pictures['pictures'] = pics
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
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 'babyReports')
      @baby_reports.each do |b|
        videos = {}
        resources = []
        videos['date'] = b.appointment_time
        uuid = b.report_document_id
        if !uuid.nil? && uuid!=''
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
        end
        videos['videos'] = resources
        videos['uuid'] = b.report_document_id
        res << videos
      end
    end
    render json: {result: res}
  end
end
