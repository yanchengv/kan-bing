#encoding: utf-8
require 'nokogiri'
class MobileTerminalController < ApplicationController
  before_filter :mobile_signed_in_user
  def baby_reports
    patientId = current_user.patient_id
    res = []
    if !patientId.nil? && patientId!=''
      @baby_reports = UsReport.where('patient_id=? and report_type=?', patientId, 'babyReports')
      @baby_reports.each do |b|
        reports = {}
        @department = Department.find(b.apply_department_id)
        reports['date'] = b.appointment_time
        reports['department'] = @department.name
        reports['doctor'] = Doctor.find(b.examine_doctor_id).name
        reports['item'] = ExaminedItem.find(b.examined_item_id).item
        reports['hospital'] = @department.hospital.name
        reports['uuid'] = b.report_document_id
        res << reports
      end
    end
    render json: {result: res}
  end

  def baby_pictures
    patientId = current_user.patient_id
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
        res << pictures
      end
    end
    render json: {result: res}
  end

  def baby_videos
    patientId = current_user.patient_id
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
        res << videos
      end
    end
    render json: {result: res}
  end
end
