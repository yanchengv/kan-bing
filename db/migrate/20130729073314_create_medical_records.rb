class CreateMedicalRecords < ActiveRecord::Migration
  def change
    create_table :medical_records do |t|
      t.integer :patient_id       ,:null=>false
      t.string :service_type_id   ,:null=>false
      t.string :visit_number      ,:null=>false
      t.integer :department_id    ,:null=>false
      t.integer :doctor_id        ,:null=>false
      t.datetime :visit_at        ,:null=>false
      t.text :visit
      t.integer :pay_type_id
      t.boolean :is_admitted
      t.boolean :is_closed

      t.timestamps
    end
  end
end
