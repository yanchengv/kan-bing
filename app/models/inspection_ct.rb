include SessionsHelper
include HealthRecordsHelper
class InspectionCt < ActiveRecord::Base
  before_create :set_pk_code
  after_create :create_inspection_report
  after_update :update_inspection_report
  after_destroy :delete_inspection_report
  attr_accessible :id,:patient_id,:parent_type,:child_type,:thumbnail,:identifier,:created_at,:doctor,:hospital,:department,:upload_user_id,:upload_user_name,:checked_at,:updated_at,:image_list, :video_list, :study_body
  belongs_to :patient, :foreign_key => :patient_id
  def set_pk_code
    self.id = pk_id_rules
  end


#根据patient_id查找CT或者核磁ID 以及instance的图片
  def find_instance_by_id patient_id, inspection_type
    # {ct:'',ct_image_url:'image',series:[{instance_num:'',series_image_url:'',seriesUID:''},{instance_num:'',series_image_url:'',seriesUID:''}]}
    @studys=[]
    case inspection_type

      when "CT"
        @inspection_cts = InspectionCt.where("patient_id=?",patient_id).order("checked_at DESC")
        if  !@inspection_cts.empty?
          @inspection_cts.each do |ct|
            studyUID=ct.thumbnail
            seriesUIDs=ct.study_body
            series_arr=[]
            if seriesUIDs!="" && !seriesUIDs.nil?
              series=seriesUIDs.split(';')
              series=series.sort {|x,y| x <=> y}
              study_image=""
              series_image=''
              if !series.nil?&& !series.empty?
                series_num=series.size

                # 获取每个series对应的第一张图片
                series.each do  |s|
                  # 获取series的uid
                  seriesUID=s.split(':')[0]
                  sop_instance_uids=s.split(':')[1]

                  # 获取instance的id
                  if  !sop_instance_uids.nil?
                    sop_instance_uids=sop_instance_uids.split(',')
                    instance_uid=sop_instance_uids[0] #获取instance的第一个id值，用做显示study和series的列表图片
                    # 获取study 和instance 图片的url
                    instance_image_url="http://www.kanbing365.com:8080/dcm4chee-arc/wado/DCM4CHEE?requestType=WADO&studyUID=#{studyUID}&seriesUID=#{seriesUID}&objectUID=#{instance_uid}"
                    study_image=instance_image_url
                    series_image=instance_image_url
                    # 获取series包含的instance数量
                    instance_num=sop_instance_uids.size

                    series_hash={series_image_url:series_image,instance_num:instance_num,seriesUID:seriesUID}
                    series_arr.push series_hash

                  end

                end


              end

              # 获取单个study（InspectionCt）下面的对象和所有的series
              study={study_object:ct,study_image_url:study_image,series:series_arr}
              @studys.push study
            end


          end



        end

      when "MR"
        @inspection_mrs = InspectionNuclearMagnetic.where("patient_id=?",patient_id).order("checked_at DESC")
        if  !@inspection_mrs.empty?
          @inspection_mrs.each do |ct|
            studyUID=ct.thumbnail
            seriesUIDs=ct.study_body
            series_arr=[]
            if seriesUIDs!="" && !seriesUIDs.nil?
              series=seriesUIDs.split(';')
              series=series.sort {|x,y| x <=> y}
              study_image=""
              series_image=''
              if !series.nil?&& !series.empty?
                series_num=series.size

                # 获取每个series对应的第一张图片
                series.each do  |s|
                  # 获取series的uid
                  seriesUID=s.split(':')[0]
                  sop_instance_uids=s.split(':')[1]

                  # 获取instance的id
                  if  !sop_instance_uids.nil?
                    sop_instance_uids=sop_instance_uids.split(',')
                    instance_uid=sop_instance_uids[0] #获取instance的第一个id值，用做显示study和series的列表图片
                    # 获取study 和instance 图片的url
                    instance_image_url="http://www.kanbing365.com:8080/dcm4chee-arc/wado/DCM4CHEE?requestType=WADO&studyUID=#{studyUID}&seriesUID=#{seriesUID}&objectUID=#{instance_uid}"
                    study_image=instance_image_url
                    series_image=instance_image_url
                    # 获取series包含的instance数量
                    instance_num=sop_instance_uids.size

                    series_hash={series_image_url:series_image,instance_num:instance_num,seriesUID:seriesUID}
                    series_arr.push series_hash

                  end

                end


              end

              # 获取单个study（InspectionCt）下面的对象和所有的series
              study={study_object:ct,study_image_url:study_image,series:series_arr}
              @studys.push study
            end


          end



        end

      else

    end





    return @studys
  end



  # 获取单个study（InspectionCt）所有的series以及series个数和图片
  def find_series_by_studyuid inspection_id, ct
    @series_instance_data=[]
    case ct
      when "CT"
        @inspection_cts=InspectionCt.where(id:inspection_id).first


        if !@inspection_cts.nil?
          studyUID=@inspection_cts.thumbnail
          seriesUIDs=@inspection_cts.study_body

          if seriesUIDs!="" && !seriesUIDs.nil?
            series=seriesUIDs.split(';')
            series=series.sort {|x,y| x <=> y}
            study_image=""
            series_image=''
            if !series.nil?&& !series.empty?
              series_num=series.size

              # 获取每个series对应的第一张图片
              series.each do  |s|
                # 获取series的uid
                seriesUID=s.split(':')[0]
                sop_instance_uids=s.split(':')[1]

                # 获取instance的id
                if  !sop_instance_uids.nil?
                  sop_instance_uids=sop_instance_uids.split(',')
                  instance_uid=sop_instance_uids[0] #获取instance的第一个id值，用做显示study和series的列表图片
                  # 获取study 和instance 图片的url
                  instance_image_url="http://www.kanbing365.com:8080/dcm4chee-arc/wado/DCM4CHEE?requestType=WADO&studyUID=#{studyUID}&seriesUID=#{seriesUID}&objectUID=#{instance_uid}"
                  study_image=instance_image_url
                  series_image=instance_image_url
                  # 获取series包含的instance数量
                  instance_num=sop_instance_uids.size

                  series_hash={series_image_url:series_image,instance_num:instance_num,seriesUID:seriesUID}
                  @series_instance_data.push series_hash

                end

              end


            end



          end
        end
      when "MR"
        @inspection_cts=InspectionNuclearMagnetic.where(id:inspection_id).first


        if !@inspection_cts.nil?
          studyUID=@inspection_cts.thumbnail
          seriesUIDs=@inspection_cts.study_body

          if seriesUIDs!="" && !seriesUIDs.nil?
            series=seriesUIDs.split(';')
            series=series.sort {|x,y| x <=> y}
            study_image=""
            series_image=''
            if !series.nil?&& !series.empty?
              series_num=series.size

              # 获取每个series对应的第一张图片
              series.each do  |s|
                # 获取series的uid
                seriesUID=s.split(':')[0]
                sop_instance_uids=s.split(':')[1]

                # 获取instance的id
                if  !sop_instance_uids.nil?
                  sop_instance_uids=sop_instance_uids.split(',')
                  instance_uid=sop_instance_uids[0] #获取instance的第一个id值，用做显示study和series的列表图片
                  # 获取study 和instance 图片的url
                  instance_image_url="http://www.kanbing365.com:8080/dcm4chee-arc/wado/DCM4CHEE?requestType=WADO&studyUID=#{studyUID}&seriesUID=#{seriesUID}&objectUID=#{instance_uid}"
                  study_image=instance_image_url
                  series_image=instance_image_url
                  # 获取series包含的instance数量
                  instance_num=sop_instance_uids.size

                  series_hash={series_image_url:series_image,instance_num:instance_num,seriesUID:seriesUID}
                  @series_instance_data.push series_hash

                end

              end


            end



          end
        end
      else

    end

    # 获取单个study（InspectionCt）下面的对象和所有的series
        return  @series_instance_data
    end



end


