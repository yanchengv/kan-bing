class InspectionReportController < ApplicationController
  before_action :checksignedin
  skip_before_filter :verify_authenticity_token
  def create
  end

  def sync_ultrasound
    # data = params[:data]
    # p data
    # para = {patient_id:data[:patient_id],patient_name:data[:patient_name],patient_code:data['patient_code'],patient_ids:data['patient_ids'],apply_department_id:data['apply_department_id'],
    #         apply_department_name:data['apply_department_name'],apply_doctor_id:data['apply_doctor_id'],apply_doctor_name:data['apply_doctor_name'],consulting_room_name:data['consulting_room_name'],
    #         consulting_room_id:data['consulting_room_id'],apply_source:data['apply_source'],us_order_id:data['apply_source'],bed_no:data['bed_no'],examined_part_name:['examined_part_name'],
    #         examined_item_name:data['examined_item_name'],charge_type:data['charge_type'],charge:data['charge'],examine_doctor_id:data['examine_doctor_id'],examine_doctor_name:data['examine_doctor_id'],
    #         examine_doctor_name:data['examine_doctor_name'],examine_doctor_code:data['examine_doctor_code'], qc_doctor_id:data['qc_doctor_id'],qc_doctor_name:data['qc_doctor_name'],is_emergency:data['is_emergency'],
    #         modality_device_id:data['modality_device_id'],initial_diagnosis:data['initial_diagnosis'],qc_status:data['qc_status'],check_start_time:data['check_start_time'],check_end_time:data['check_end_time'],
    #         print_count:data['print_count'],technician_id:data['technician_id'],technician_name:data['technician_name'],inputer_id:data['inputer_id'],inputer_name:data['inputer_name'],image_list:data['image_list'],
    #         report_image_list:data['report_image_list'],video_list:data['video_list'],us_finding:data['us_finding'],us_diagnose:data['us_diagnose'],statics:data['statics'],station_fee:data['station_fee'],
    #         report_print_fee:data['report_print_fee'],item_fee:data['item_fee'],desc_fee:data['desc_fee']}
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
                                 :inputer_name,:report_image_list,:us_finding,:us_diagnose,:statics,:station_fee,:report_print_fee,:item_fee,:desc_fee)
  end
end
