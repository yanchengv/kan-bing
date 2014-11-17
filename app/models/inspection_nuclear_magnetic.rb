include SessionsHelper
include HealthRecordsHelper
class InspectionNuclearMagnetic < ActiveRecord::Base
  before_create :set_pk_code
  after_create :create_inspection_report
  after_destroy :delete_inspection_report
  attr_accessible :id,:patient_id,:parent_type,:child_type,:thumbnail,:identifier,:created_at,:doctor,:hospital,:department,:upload_doctor_id,:upload_doctor_name,:checked_at,:updated_at,:image_list, :video_list, :study_body
  belongs_to :patient, :foreign_key => :patient_id
  def set_pk_code
    self.id = pk_id_rules
  end
end
