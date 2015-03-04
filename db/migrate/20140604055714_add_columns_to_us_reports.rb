class AddColumnsToUsReports < ActiveRecord::Migration
  def up
    add_column :us_reports, :patient_name, :string
    add_column :us_reports, :apply_department_name, :string
    add_column :us_reports, :apply_doctor_name, :string
    add_column :us_reports, :consulting_room_name, :string
    add_column :us_reports, :examined_part_name, :string
    add_column :us_reports, :examined_item_name, :string
    add_column :us_reports, :examine_doctor_name, :string
    add_column :us_reports, :created_by_name, :string
    add_column :us_reports, :controller_by_name, :string
    add_column :us_reports, :technician_name, :string
  end

  def down
    remove_column :us_reports, :patient_name
    remove_column :us_reports, :apply_department_name
    remove_column :us_reports, :apply_doctor_name
    remove_column :us_reports, :consulting_room_name
    remove_column :us_reports, :examined_part_name
    remove_column :us_reports, :examined_item_name
    remove_column :us_reports, :examine_doctor_name
    remove_column :us_reports, :created_by_name
    remove_column :us_reports, :controller_by_name
    remove_column :us_reports, :technician_name
  end
end
