class MainTell < ActiveRecord::Base
   belongs_to :diagnose_treat
  attr_accessible :tell_content,:doctor_id,:patient_id,:diagnose_treat_id,:teller, :create_time,:doctor_name
end
