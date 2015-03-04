class CreateUsWorklists < ActiveRecord::Migration
  def change
    create_table :us_worklists, :id=>false  do |t|
      t.integer :id, :limit=>8
      t.integer :patient_id, :null => false
      t.string :patient_ids, :null => false
      t.integer :apply_department_id
      t.integer :apply_doctor_id, :null => false
      t.integer :consulting_room_id
      t.datetime :appointment_time
      t.integer :apply_source, :default => 0
      t.string :source_code, :null => false
      t.integer :bed_no
      t.integer :examined_part_id, :null => false
      t.integer :examined_item_id , :null => false
      t.float :charge, :default => 0.0
      t.integer :examine_doctor_id
      t.boolean :is_emergency, :default => false
      t.string :created_by
      t.string :update_by
      t.text :description
      t.string :study_iuid
      t.integer :status, :default => 0
      t.string :modality


      t.timestamps
    end
    add_index :us_worklists, :patient_id
    add_index :us_worklists, :patient_ids
    add_index :us_worklists, :apply_department_id
    add_index :us_worklists, :apply_doctor_id
    add_index :us_worklists, :consulting_room_id
    add_index :us_worklists, :appointment_time
    add_index :us_worklists, :apply_source
    add_index :us_worklists, :examined_part_id
    add_index :us_worklists, :examined_item_id
    add_index :us_worklists, :examine_doctor_id
    add_index :us_worklists, :created_by
    add_index :us_worklists, :is_emergency
    add_index :us_worklists, :study_iuid
    add_index :us_worklists, :status
    add_index :us_worklists, :modality
  end
end
