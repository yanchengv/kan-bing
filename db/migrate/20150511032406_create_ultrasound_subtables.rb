class CreateUltrasoundSubtables < ActiveRecord::Migration
  def change
    create_table :ultrasound_subtables, :id => false do |t|
      t.integer :id, :limit => 8
      t.integer :inspection_ultrasound_id, :limit => 8
      t.string :identifier
      t.string :study_body
      t.string :upload_user_id
      t.string :upload_user_name
      t.string :patient_code
      t.string :patient_ids
      t.string :consulting_room_name
      t.string :consulting_room_id
      t.string :charge_type
      t.float :charge
      t.string :qc_doctor_id
      t.string :qc_doctor_name
      t.boolean :is_emergency
      t.string :modality_device_id
      t.text :initial_diagnosis
      t.integer :print_count
      t.string :technician_id
      t.string :technician_name
      t.text :statics
      t.float :station_fee
      t.float :report_print_fee
      t.float :item_fee
      t.float :desc_fee
      t.string :keep_word
      t.string :examine_doctor_code

      t.timestamps
    end
    execute "ALTER TABLE ultrasound_subtables ADD PRIMARY KEY (id);"
    add_index :ultrasound_subtables, :inspection_ultrasound_id
  end
end
