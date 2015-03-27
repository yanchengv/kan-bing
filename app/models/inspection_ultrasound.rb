include SessionsHelper
include HealthRecordsHelper
class InspectionUltrasound < ActiveRecord::Base
  before_create :set_pk_code
  after_create :create_inspection_report
  after_update :update_inspection_report
  after_destroy :delete_inspection_report
  attr_accessible :id, :patient_id, :patient_name, :patient_code, :parent_type, :child_type, :thumbnail, :identifier,
                  :doctor, :hospital, :department, :checked_at, :upload_user_id, :upload_user_name, :image_list,
                  :video_list, :study_body, :patient_ids, :apply_department_id, :apply_department_name, :apply_doctor_id,
                  :apply_doctor_name, :consulting_room_name, :consulting_room_id, :apply_source, :us_order_id, :bed_no,
                  :examined_part_name, :examined_item_name, :charge_type, :charge, :examine_doctor_id, :examine_doctor_name,
                  :examine_doctor_code, :qc_doctor_id, :qc_doctor_name, :is_emergency, :modality_device_id, :initial_diagnosis,
                  :qc_status, :check_start_time, :check_end_time, :print_count, :technician_id, :technician_name, :inputer_id ,
                  :inputer_name,:report_image_list,:us_finding,:us_diagnose,:statics,:station_fee,:report_print_fee,:item_fee,:desc_fee,:_id,:clinic_no,:hospitalized_no
  belongs_to :patient, :foreign_key => :patient_id
  def set_pk_code
    self.id = pk_id_rules
  end
end
