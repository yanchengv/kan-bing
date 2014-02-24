class UsReport < ActiveRecord::Base
  attr_accessible :patient_id,
                  :patient_ids,
                  :apply_department_id,
                  :apply_doctor_id,
                  :consulting_room_id,
                  :appointment_time,
                  :apply_source,
                  :source_code,
                  :bed_no,
                  :examined_part_id,
                  :examined_item_id,
                  :charge_type_id,
                  :charge,
                  :examine_doctor_id,
                  :is_emergency,
                  :created_by,
                  :modality,
                  :positive_grade,
                  :initial_diagnosis,
                  :equipment,
                  :approval_status,
                  :check_start_time,
                  :check_end_time,
                  :report_document_id,
                  :controller_by,
                  :follow_up_result,
                  :print_total ,
                  :notification_id,
                  :technician_id,
                  :id,
                  :created_at,
                  :updated_at

end
