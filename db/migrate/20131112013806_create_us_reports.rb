class CreateUsReports < ActiveRecord::Migration
  def change
    create_table :us_reports, :id => false  do |t|
      t.integer :id, :limit => 8
      t.integer :patient_id
      t.string :patient_ids, :null => false
      t.integer :apply_department_id, :null => false
      t.integer :apply_doctor_id, :null => false
      t.integer :consulting_room_id
      t.date :appointment_time
      t.integer :apply_source, :default => 0
      t.string :source_code, :null => false
      t.integer :bed_no
      t.integer :examined_part_id, :null => false
      t.integer :examined_item_id, :null => false
      t.integer :charge_type_id
      t.float :charge
      t.integer :examine_doctor_id
      t.boolean :is_emergency, :default => false
      t.string :created_by, :null => false
      t.string :modality
      t.string :positive_grade
      t.text :initial_diagnosis
      t.integer :equipment
      t.integer :approval_status, :default => 0
      t.date :check_start_time
      t.date :check_end_time
      t.string :report_document_id
      t.integer :controller_by
      t.text :follow_up_result


      t.timestamps
    end
    execute "ALTER TABLE us_reports ADD PRIMARY KEY (id);"

    add_index :us_reports, :patient_id
    add_index :us_reports, :patient_ids
    add_index :us_reports, :apply_department_id
    add_index :us_reports, :apply_doctor_id
    add_index :us_reports, :consulting_room_id
    add_index :us_reports, :appointment_time
    add_index :us_reports, :apply_source
    add_index :us_reports, :examined_part_id
    add_index :us_reports, :examined_item_id
    add_index :us_reports, :charge_type_id
    add_index :us_reports, :examine_doctor_id
    add_index :us_reports, :is_emergency
    add_index :us_reports, :created_by
    add_index :us_reports, :approval_status
    add_index :us_reports, :check_start_time
    add_index :us_reports, :report_document_id
    add_index :us_reports, :controller_by
  end
end
