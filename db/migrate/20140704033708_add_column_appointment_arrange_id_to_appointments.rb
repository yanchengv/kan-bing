class AddColumnAppointmentArrangeIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments,:appointment_arrange_id, :integer, :limit => 8
    add_index :appointments,:appointment_arrange_id
  end
end
