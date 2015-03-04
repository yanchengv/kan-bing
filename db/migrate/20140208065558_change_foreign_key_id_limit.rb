class ChangeForeignKeyIdLimit < ActiveRecord::Migration
  def change
    #user_id
    change_column :users_workspaces, :user_id, :integer, :limit => 8
    change_column :assessments, :user_id, :integer, :limit => 8
    change_column :appointments, :user_id, :integer, :limit => 8
    change_column :notifications, :user_id, :integer, :limit => 8

    #patient_id
    change_column :users, :patient_id, :integer, :limit => 8
    change_column :surgeries, :patient_id, :integer, :limit => 8
    change_column :medical_records, :patient_id, :integer, :limit => 8
    change_column :inpatient_records, :patient_id, :integer, :limit => 8
    change_column :surgery_logs, :patient_id, :integer, :limit => 8
    change_column :us_worklists, :patient_id, :integer, :limit => 8
    change_column :us_reports, :patient_id, :integer, :limit => 8
    change_column :basic_health_records, :patient_id, :integer, :limit => 8

    #doctor_id
    change_column :users, :doctor_id, :integer, :limit => 8
    change_column :surgeries, :master_doctor_id, :integer, :limit => 8
    change_column :surgeries, :apply_doctor_id, :integer, :limit => 8
    change_column :surgeries, :arranger_doctor_id, :integer, :limit => 8
    change_column :surgeries, :anesthesia_doctor_id, :integer, :limit => 8
    change_column :medical_records, :doctor_id, :integer, :limit => 8
    change_column :surgeries_operating_rooms, :anesthesia_doctor_id, :integer, :limit => 8
    change_column :surgeries_operating_rooms, :arranger_doctor_id, :integer, :limit => 8
    change_column :us_reports, :apply_doctor_id, :integer, :limit => 8
    change_column :us_reports, :examine_doctor_id, :integer, :limit => 8
    change_column :surgery_doctors, :doctor_id, :integer, :limit => 8
    change_column :us_worklists, :apply_doctor_id, :integer, :limit => 8
    change_column :us_worklists, :examine_doctor_id, :integer, :limit => 8
    change_column :appointments, :doctor_id, :integer, :limit => 8
    change_column :appointment_avalibles, :avalibledoctor_id, :integer, :limit => 8
#    change_column :appointment_schedules, :doctor_id, :integer, :limit => 8

    #nurse_id
    change_column :users, :nurse_id, :integer, :limit => 8
    change_column :surgeries, :patrol_nurse_id, :integer, :limit => 8
    change_column :surgeries, :appliance_nurse_id, :integer, :limit => 8
    change_column :surgery_nurses, :nurse_id, :integer, :limit => 8
    change_column :surgery_nurses, :appliance_nurse_id, :integer, :limit => 8
  end
end
