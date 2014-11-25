include SessionsHelper
class InspectionReport<ActiveRecord::Base
  belongs_to :patient,:foreign_key => :patient_id
  before_create :set_pk_code
  attr_accessible :id,:patient_id,:parent_type,:child_type,:thumbnail,:identifier,:created_at,:doctor,:hospital,:department,:child_id,:upload_user_id,:upload_user_name,:checked_at,:updated_at,:image_list,:video_list, :study_body
  def set_pk_code
    self.id = pk_id_rules
  end
end