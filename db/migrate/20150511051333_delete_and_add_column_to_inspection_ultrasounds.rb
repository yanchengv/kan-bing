class DeleteAndAddColumnToInspectionUltrasounds < ActiveRecord::Migration
  def change
    remove_column :inspection_ultrasounds,:identifier
    remove_column :inspection_ultrasounds,:study_body
    remove_column :inspection_ultrasounds,:upload_user_id
    remove_column :inspection_ultrasounds,:upload_user_name
    remove_column :inspection_ultrasounds,:patient_code
    remove_column :inspection_ultrasounds,:patient_ids
    remove_column :inspection_ultrasounds,:consulting_room_id
    remove_column :inspection_ultrasounds,:consulting_room_name
    remove_column :inspection_ultrasounds,:charge_type
    remove_column :inspection_ultrasounds,:charge
    remove_column :inspection_ultrasounds,:qc_doctor_id
    remove_column :inspection_ultrasounds,:qc_doctor_name
    remove_column :inspection_ultrasounds,:is_emergency
    remove_column :inspection_ultrasounds,:modality_device_id
    remove_column :inspection_ultrasounds,:initial_diagnosis
    remove_column :inspection_ultrasounds,:print_count
    remove_column :inspection_ultrasounds,:technician_id
    remove_column :inspection_ultrasounds,:technician_name
    remove_column :inspection_ultrasounds,:statics
    remove_column :inspection_ultrasounds,:station_fee
    remove_column :inspection_ultrasounds,:report_print_fee
    remove_column :inspection_ultrasounds,:item_fee
    remove_column :inspection_ultrasounds,:desc_fee
    remove_column :inspection_ultrasounds,:examine_doctor_code
    remove_column :inspection_ultrasounds,:clinic_no
    remove_column :inspection_ultrasounds,:hospitalized_no

    add_column :inspection_ultrasounds, :data_source_number, :string
    add_column :inspection_ultrasounds, :birthday, :date
    add_column :inspection_ultrasounds, :device_type, :string
    add_column :inspection_ultrasounds, :gender, :string
  end
end
