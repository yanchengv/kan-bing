class ChangeColumnScheduleIdToAppointmentArranges < ActiveRecord::Migration
  def change
    change_column :appointment_arranges, :schedule_id, :integer, :limit => 8
  end
end
