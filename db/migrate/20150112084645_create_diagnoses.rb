class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.string :name
      t.integer :doctor_id,limit:8
      t.integer :patient_id,limit:8
      t.datetime :create_time
      t.text :content
      t.integer :diagnose_treat_id
      t.text :according
      t.string  :doctor_name
      t.timestamps
    end
  end
end
