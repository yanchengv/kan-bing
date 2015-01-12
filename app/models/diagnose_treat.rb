# 诊疗表
class DiagnoseTreat < ActiveRecord::Base
  has_many :main_tells,dependent: :destroy
  has_many :diagnose,dependent: :destroy
  has_many :doctor_orders,dependent: :destroy
  attr_accessible :name,:doctor_id,:patient_id,:create_time

end
