include SessionsHelper
include HealthRecordsHelper
class InspectionUltrasound < ActiveRecord::Base
  before_create :set_pk_code
  after_create :create_inspection_ult_report
  after_update :update_inspection_ult_report
  after_destroy :delete_inspection_report
  attr_accessible :id, :patient_id, :patient_name, :parent_type, :child_type, :thumbnail,
                  :doctor, :hospital, :department, :checked_at,:image_list,
                  :video_list, :apply_department_id, :apply_department_name, :apply_doctor_id,
                  :apply_doctor_name,:apply_source, :us_order_id, :bed_no,
                  :examined_part_name, :examined_item_name,  :examine_doctor_id, :examine_doctor_name,
                  :qc_status, :check_start_time, :check_end_time, :inputer_id ,
                  :inputer_name,:report_image_list,:us_finding,:us_diagnose,:_id, :data_source_number,:gender,:birthday,:device_type
  belongs_to :patient, :foreign_key => :patient_id
  has_one :ultrasound_subtable , :dependent => :destroy
  def set_pk_code
    self.id = pk_id_rules
  end
end
