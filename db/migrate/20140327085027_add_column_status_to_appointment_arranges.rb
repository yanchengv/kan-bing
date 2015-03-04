class AddColumnStatusToAppointmentArranges < ActiveRecord::Migration
  def change
    add_column :appointment_arranges, :status, :integer
  end
end
