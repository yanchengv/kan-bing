class DiagnoseType < ActiveRecord::Base
  has_many :medical_diagnoses#, :dependent => :destroy
  attr_accessible :id, :type_name
end
