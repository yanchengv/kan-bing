class DoctorOrder < ActiveRecord::Base
  belongs_to :diagnose_treat
  attr_accessible   :create_time,:start_time, :valid_time,:doctor_id, :patient_id,:diagnose_treat_id,:executor,:content,:order_type,:according,:doctor_name
end
