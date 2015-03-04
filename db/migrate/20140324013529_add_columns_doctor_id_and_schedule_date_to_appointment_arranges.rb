class AddColumnsDoctorIdAndScheduleDateToAppointmentArranges < ActiveRecord::Migration
  def change
    add_column :appointment_arranges, :doctor_id, :integer, :limit => 8
    add_column :appointment_arranges, :schedule_date, :date
    rename_column :appointment_arranges, :modality_device_id, :schedule_id
  end
end
