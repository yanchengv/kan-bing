class ScheduleTemplate < ActiveRecord::Base
  include SessionsHelper
  before_create :set_pk_code
  attr_accessible :id,:doctor_id,:dayofweek,:start_time,:end_time,:number
  def set_pk_code
    self.id = pk_id_rules
  end
end
