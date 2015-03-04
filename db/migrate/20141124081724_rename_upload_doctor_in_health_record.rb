class RenameUploadDoctorInHealthRecord < ActiveRecord::Migration
  def change
    rename_column :inspection_reports, :upload_doctor_id, :upload_user_id
    rename_column :inspection_reports, :upload_doctor_name, :upload_user_name

    rename_column :inspection_cts, :upload_doctor_id, :upload_user_id
    rename_column :inspection_cts, :upload_doctor_name, :upload_user_name

    rename_column :inspection_data, :upload_doctor_id, :upload_user_id
    rename_column :inspection_data, :upload_doctor_name, :upload_user_name

    rename_column :inspection_ultrasounds, :upload_doctor_id, :upload_user_id
    rename_column :inspection_ultrasounds, :upload_doctor_name, :upload_user_name

    rename_column :inspection_nuclear_magnetics, :upload_doctor_id, :upload_user_id
    rename_column :inspection_nuclear_magnetics, :upload_doctor_name, :upload_user_name
  end
end
