class Diagnose < ActiveRecord::Base
  belongs_to :diagnose_treat
  attr_accessible :name, :doctor_id,:patient_id,:create_time,:content,:diagnose_treat_id,:according
end
