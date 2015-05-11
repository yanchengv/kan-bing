class InspectionReportController < ApplicationController
  before_action :token_checksingn
  skip_before_filter :verify_authenticity_token
  def create
  end

  def sync_ultrasound_save
    if params[:data].nil? || params[:data][:patient_id].nil? || params[:data][:patient_id]==''
      render json: {success:false,msg:'data[patient_id]为必填参数!'}
      return
    end
    @patient = Patient.where(_id:params[:data][:patient_id]).first
    if !@patient.nil?
      params[:data][:patient_id] = @patient.id
      params[:data][:parent_type] = '影像数据'
      params[:data][:child_type] = '超声'
      if !params[:data][:doctor].nil? && params[:data][:doctor] !=''
        params[:data][:doctor] = params[:data][:examine_doctor_name]
      end
      @examine_doctor = Doctor.where(id:params[:data][:examine_doctor_id]).first
      if !@examine_doctor.nil? && !params[:data][:hospital].nil? && params[:data][:hospital] !=''
        params[:data][:hospital] = @examine_doctor.hospital_name
      end
      if !@examine_doctor.nil? && !params[:data][:department].nil? && params[:data][:department] !=''
        params[:data][:department] = @examine_doctor.department_name
      end
      if params[:data][:checked_at].nil? || params[:data][:checked_at] == ''
        params[:data][:checked_at] = Time.now
        if !params[:data][:check_end_time].nil? &&  params[:data][:check_end_time] != ''
          params[:data][:checked_at] = params[:data][:check_end_time]
        end
      end
      @ins_ult = InspectionUltrasound.new(inspection_ultrasound_params)
      if @ins_ult.save
        # params[:inspection_ultrasound_id] = @ins_ult.id
        param = {inspection_ultrasound_id:@ins_ult.id,examine_doctor_code:params[:data][:examine_doctor_code],initial_diagnosis:params[:data][:initial_diagnosis],
                qc_doctor_id:params[:data][:qc_doctor_id],qc_doctor_name:params[:data][:qc_doctor_name],is_emergency:params[:data][:is_emergency],modality_device_id:
                params[:data][:modality_device_id],print_count:params[:data][:print_count],technician_id:params[:data][:technician_id],technician_name:params[:data][:technician_name],
                statics:params[:data][:statics],station_fee:params[:data][:station_fee],report_print_fee:params[:data][:report_print_fee],item_fee:params[:data][:item_fee],
                desc_fee:params[:data][:desc_fee],consulting_room_name:params[:data][:consulting_room_name],consulting_room_id:params[:data][:consulting_room_id],
                charge_type:params[:data][:charge_type],charge:params[:data][:charge],keep_word:params[:data][:keep_word]}
        UltrasoundSubtable.create(param)
        #  推送微信消息
        #aes解密
           require "aes"
          key = '290c3c5d812a4ba7ce33adf09598a462'
          patient_id=AES.encrypt(@ins_ult.patient_id.to_s,key)
          report_id=  AES.encrypt(@ins_ult.id.to_s,key)
           WeixinUser.new.send_health_tempate_message patient_id,report_id,"ultrasound",key

        render json: {success:true, data:@ins_ult}
      else
        render json: {success:false}
      end
    else
      render json: {success:false,msg:'患者不存在!'}
    end
  end

  def sync_ultrasound_update
    if params[:ultrasound_id].nil? || params[:ultrasound_id]==''
      render json: {success:false,msg:'ultrasound_id为必填参数!'}
      return
    end
    @ins_ult = InspectionUltrasound.where(id:params[:ultrasound_id]).first
    if !params[:data][:doctor].nil? && params[:data][:doctor] !=''
      params[:data][:doctor] = params[:data][:examine_doctor_name]
    end
    @examine_doctor = Doctor.where(id:params[:data][:examine_doctor_id]).first
    if !@examine_doctor.nil? && !params[:data][:hospital].nil? && params[:data][:hospital] !=''
      params[:data][:hospital] = @examine_doctor.hospital_name
    end
    if !@examine_doctor.nil? && !params[:data][:department].nil? && params[:data][:department] !=''
      params[:data][:department] = @examine_doctor.department_name
    end
    if params[:data][:checked_at].nil? || params[:data][:checked_at] == ''
      params[:data][:checked_at] = Time.now
      if !params[:data][:check_end_time].nil? &&  params[:data][:check_end_time] != ''
        params[:data][:checked_at] = params[:data][:check_end_time]
      end
    end
    if !@ins_ult.nil? && @ins_ult.update(inspection_ultrasound_params)
      render json: {success:true, data:@ins_ult}
    else
      render json: {success:false}
    end
  end

  def sync_ultrasound_destroy
    if params[:_id].nil? || params[:_id]==''
      render json: {success:false,data:'无效_id'}
    else
      @ins_ult = InspectionUltrasound.where(_id:params[:_id]).first
      p @ins_ult
      if !@ins_ult.nil? && @ins_ult.destroy
        render json: {success:true, data:@ins_ult}
      else
        render json: {success:false}
      end
    end
  end

  private
  def inspection_ultrasound_params
    params.require(:data).permit(:id, :patient_id, :patient_name, :parent_type, :child_type, :thumbnail,:doctor, :hospital, :department, :checked_at,
                                  :image_list,:video_list,:apply_department_id, :apply_department_name, :apply_doctor_id,:apply_doctor_name, :apply_source, :us_order_id,
                                  :bed_no,:examined_part_name, :examined_item_name,  :examine_doctor_id, :examine_doctor_name,:qc_status,
                                  :check_start_time, :check_end_time, :inputer_id ,:inputer_name,:report_image_list,:us_finding,
                                 :us_diagnose,:_id,:data_source_number,:gender,:birthday,:device_type)
  end
  def ultrasound_subtable_params
    params.permit(:id,:inspection_ultrasound_id,:patient_code,:identifier, :upload_user_id, :upload_user_name, :study_body, :patient_ids, :examine_doctor_code,
                  :initial_diagnosis,:qc_doctor_id, :qc_doctor_name, :is_emergency, :modality_device_id,:print_count, :technician_id, :technician_name,
                  :statics,:station_fee,:report_print_fee,:item_fee,:desc_fee,:consulting_room_name, :consulting_room_id,:charge_type, :charge,:keep_word)
  end
end
