class AddColumnsToAppointments < ActiveRecord::Migration
  def up
    add_column :appointments, :patient_name, :string
    add_column :appointments, :doctor_name, :string
    add_column :appointments, :hospital_name, :string
    add_column :appointments, :department_name, :string
    add_column :appointments, :dictionary_name, :string
  end

  def down
    remove_column :appointments, :patient_name
    remove_column :appointments, :doctor_name
    remove_column :appointments, :hospital_name
    remove_column :appointments, :department_name
    remove_column :appointments, :dictionary_name
  end
end
