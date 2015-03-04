class AddColumnModalityDeviceIdToAppointmentArranges < ActiveRecord::Migration
  def change
    add_column :appointment_arranges, :modality_device_id, :integer
  end
end
