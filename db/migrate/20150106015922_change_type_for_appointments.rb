class ChangeTypeForAppointments < ActiveRecord::Migration
  def change
    change_column :appointments, :hospital_id, :integer, :limit => 8
    change_column :appointments, :department_id, :integer, :limit => 8
  end
end
