class MedicalDiagnose < ActiveRecord::Base
  belongs_to :diagnose_type, :foreign_key => :diagnose_type_id
  attr_accessible :id, :title, :created_by_id, :created_by_name, :diagnose_type_id
end
