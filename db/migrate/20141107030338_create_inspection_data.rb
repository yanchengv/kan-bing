class CreateInspectionData < ActiveRecord::Migration
  def change
    create_table :inspection_data, id:false do |t|
      t.integer :id, :limit => 8
      t.integer :patient_id,  :limit => 8
      t.string :parent_type
      t.string :child_type
      t.string :thumbnail
      t.string :identifier
      t.string :doctor
      t.string :hospital
      t.string :department
      t.date :checked_at
      t.integer :upload_doctor_id, :limit => 8
      t.string :upload_doctor_name
      t.timestamps
    end
    execute "ALTER TABLE inspection_data ADD PRIMARY KEY (id);"
  end
end
