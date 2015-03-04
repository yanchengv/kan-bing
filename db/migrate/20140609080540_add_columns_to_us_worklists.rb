class AddColumnsToUsWorklists < ActiveRecord::Migration
  def up
    add_column :us_worklists, :patient_name, :string
    add_column :us_worklists, :patient_code, :string
    add_column :us_worklists, :apply_department_name, :string
    add_column :us_worklists, :apply_doctor_name, :string
    add_column :us_worklists, :consulting_room_name, :string
    add_column :us_worklists, :examined_part_name, :string
    add_column :us_worklists, :examined_item_name, :string
    add_column :us_worklists, :examine_doctor_name, :string
    add_column :us_worklists, :examine_doctor_code, :string
    add_column :us_worklists, :created_by_name, :string
    add_column :us_worklists, :update_by_name, :string
    add_column :us_worklists, :technician_name, :string

    add_column :us_reports, :patient_code, :string
    add_column :us_reports, :examine_doctor_code, :string
  end

  def down
    remove_column :us_worklists, :patient_name
    remove_column :us_worklists, :patient_code
    remove_column :us_worklists, :apply_department_name
    remove_column :us_worklists, :apply_doctor_name
    remove_column :us_worklists, :consulting_room_name
    remove_column :us_worklists, :examined_part_name
    remove_column :us_worklists, :examined_item_name
    remove_column :us_worklists, :examine_doctor_name
    remove_column :us_worklists, :examine_doctor_code
    remove_column :us_worklists, :created_by_name
    remove_column :us_worklists, :update_by_name
    remove_column :us_worklists, :technician_name

    remove_column :us_reports, :patient_code
    remove_column :us_reports, :examine_doctor_code
  end
end
