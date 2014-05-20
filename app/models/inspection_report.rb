include SessionsHelper
class InspectionReport<ActiveRecord::Base
  before_create :set_pk_code
  attr_accessible :id,:patient_id,:parent_type,:child_type,:thumbnail,:identifier,:created_at,:doctor,:hospital,:department,:checked_at,:updated_at
  def set_pk_code
    self.id = pk_id_rules
  end
end