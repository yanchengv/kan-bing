include SessionsHelper
class UltrasoundSubtable < ActiveRecord::Base
  before_create :set_pk_code
  belongs_to :inspection_ultrasound, :foreign_key => :inspection_ultrasound_id
  attr_accessible :id,:inspection_ultrasound_id,:identifier,:study_body,:upload_user_id,
  :upload_user_name,:patient_code,:patient_ids,:consulting_room_name,
  :consulting_room_id,:charge_type,:charge,:qc_doctor_id,:qc_doctor_name,:is_emergency,
  :modality_device_id,:initial_diagnosis,:print_count,:technician_id,
  :technician_name,:statics,:station_fee,:report_print_fee,
  :item_fee,:desc_fee,:keep_word,:examine_doctor_code

  def set_pk_code
    self.id = pk_id_rules
  end
end

