class BloodOxygen < ActiveRecord::Base
  #pulse_rate:脉率、o_saturation:血氧饱和度、灌注指数（PI）
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :patient_id,:pulse_rate,:o_saturation,:pi ,:measure_time
end
