class ArchiveQueue < ActiveRecord::Base  
  attr_accessible   :upload_user_id,   :upload_user_name ,   :parent_type,   :child_type,   :filename,   :filesize,   :extname,   :hospital_id,   :hospital_name,   :department_id,   :department_name,   :doctor_id,   :doctor_name,   :patient_id,   :patient_name,   :status 
end