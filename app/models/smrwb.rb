#   肌肉率表
class Smrwb < ActiveRecord::Base

  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id,:measure_value,:measure_time,:is_true,:mdevice
end
