class CreateInpatientRecords < ActiveRecord::Migration
  def change
    create_table :inpatient_records do |t|
      t.integer :patient_id     ,:null=>false
      t.datetime :admitted_date    ,:null=>false
      t.string :inpatient_number   ,:null=>false
      t.integer :department_id      ,:null=>false
      t.integer :inpatient_area_id  ,:null=>false
      t.integer :bed              ,:null=>false
      t.date :confirmed_date
      t.boolean :is_under_treatment ,:null=>false
      t.date :discharge_date
      t.text :discharge_diagnose
      t.text :discharge_description

      t.timestamps
    end
  end
end
