class InspectionReportController < ApplicationController
  before_action :token_checksingn
  skip_before_filter :verify_authenticity_token
  def create
  end

  def sync_ultrasound_save
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
      render json: {success:false}
    end
  end

  def sync_ultrasound_update
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
    @ins_ult = InspectionUltrasound.where(id:params[:ultrasound_id]).first
    if !@ins_ult.nil? && @ins_ult.destroy
      render json: {success:true, data:@ins_ult}
    else
      render json: {success:false}
    end
  end

  private
  def inspection_ultrasound_params
    params.require(:data).permit(:id, :patient_id, :patient_name, :patient_code, :parent_type, :child_type, :thumbnail, :identifier,
                                 :doctor, :hospital, :department, :checked_at, :upload_user_id, :upload_user_name, :image_list,
                                 :video_list, :study_body, :patient_ids, :apply_department_id, :apply_department_name, :apply_doctor_id,
                                 :apply_doctor_name, :consulting_room_name, :consulting_room_id, :apply_source, :us_order_id, :bed_no,
                                 :examined_part_name, :examined_item_name, :charge_type, :charge, :examine_doctor_id, :examine_doctor_name,
                                 :examine_doctor_code, :qc_doctor_id, :qc_doctor_name, :is_emergency, :modality_device_id, :initial_diagnosis,
                                 :qc_status, :check_start_time, :check_end_time, :print_count, :technician_id, :technician_name, :inputer_id ,
                                 :inputer_name,:report_image_list,:us_finding,:us_diagnose,:statics,:station_fee,:report_print_fee,:item_fee,:desc_fee,:_id)
  end
end
