# encoding: utf-8
class HealthRecord
  require 'json'
  require 'aliyun/oss'
  require 'open-uri'
  require 'aliyun/oss/bucket'
  include Aliyun::OSS
  # To change this template use File | Settings | File Templates.

  #dicom 上传阿里云
  def upload_to(patient_id,root_url,upload_user_id)
    @flag = false
      path = Settings.dicom+'dcm4chee-arc/stow/DCM4CHEE/studies'
      response = HTTMultiParty.post(path, :query => {
          :filename => File.new(root_url)
      })
      rep_json = Hash.from_xml(response.body).as_json
      dicom_att =  rep_json['NativeDicomModel']['DicomAttribute']
      url_path = ''
      if !dicom_att.nil? && !dicom_att.empty?
        dicom_att.each do |att|
          item = att['Item']
          if !item.nil?
            dicoms = item['DicomAttribute']
            if !dicoms.nil? && !dicoms.empty?
              dicoms.each do |dic|
                if dic['keyword'] == "RetrieveURL"
                  url_path = dic['Value']
                end
              end
            end
          end
        end
      end
      stu_index = url_path.index("studies/")#  8
      ser_index = url_path.index("series/")#  7
      ins_index = url_path.index("instances/")#  10
      studies = url_path[stu_index+8..(ser_index-2)]
      series = url_path[ser_index+7..(ins_index-2)]
      instances = url_path[ins_index+10..-1]
      # p studies
      # p series
      # p instances
      path2 = Settings.dicom+"dcm4chee-arc/qido/DCM4CHEE/studies/"+studies+"/series?includefield=all"
      studies_list = HTTParty.get(path2).as_json
      child_type = ''
      check_at = ''
      hospital = ''
      # doctor = ''
      if !studies_list.empty?
        studies_list.each do |studie|
          if studie["StudyInstanceUID"]["Value"][0] == studies
            child_type = studie["ModalitiesInStudy"]["Value"][0]
            check_at = studie["StudyDate"]["Value"][0]
            hospital = studie["InstitutionName"]["Value"][0]
            # doctor = studie[""]
            if !studie["PatientName"].nil?
              patient_name = studie["PatientName"]["PersonName"][0]["Alphabetic"]
            end
          end
        end
      end
      upload_user_name=''
      if !upload_user_id.nil?
        upload_user_name = User.select("name").where(id:upload_user_id).first.name
      end
      ins_dicm = InspectionCt.where(patient_id:patient_id,thumbnail: studies).first
      if ins_dicm.nil?
        InspectionCt.create(patient_id:patient_id,parent_type:'影像数据',checked_at:check_at,hospital:hospital,upload_user_id:upload_user_id,upload_user_name:upload_user_name,child_type:child_type,thumbnail:studies,study_body:series+":"+instances)
        @flag = true
      else
        series_list = ins_dicm.study_body
        series_arr = series_list.split(";")
        study_body = ''
        if !series_arr.empty?
          flag = false
          series_arr.each do |serie_list|
            index = serie_list.index(":")
            serie = serie_list[0..index-1]
            instances_list = serie_list[index+1..-1]
            # if flag == false
              if serie == series
                flag = true
                instances_arr = instances_list.split(",")
                if !instances_arr.empty?
                  flag2 = false
                  instances_arr.each do |instance|
                    if instance == instances
                      flag2 = true
                    end
                  end
                  if flag2 == false
                    instances_list << ","+instances
                  else
                  end
                end
              end
            # end
            if study_body == ''
              study_body << serie + ":" + instances_list
            else
              study_body << ";" + serie + ":" + instances_list
            end
          end
          if flag == false
            study_body = ins_dicm.study_body + ";" + series + ":" + instances
          end
        else
          study_body = series + ":" + instances
        end
        ins_dicm.update(study_body:study_body)
        @flag = true
      end
    return @flag
  end

  #超声报告和检验报告上传到阿里云
     def report_upload_aliyun file_name,file_url
       #连接信息
       aliyun_establish_connection
       #上传
       mimas_dev_bucket = Bucket.find(Settings.aliyunOSS.image_bucket) #查找Bucket
       obj = mimas_dev_bucket.new_object #在此Bucket新建Object
       obj.key = file_name
       obj.value= open(file_url)
       obj.store

       return  file_name
     end



  private
  #连接信息
  def aliyun_establish_connection
    Aliyun::OSS::Base.establish_connection!(
        :server => Settings.aliyunOSS.beijing_server, #可不填,默认为此项
        :access_key_id => Settings.aliyunOSS.access_key_id,
        :secret_access_key => Settings.aliyunOSS.secret_access_key
    )
  end

end