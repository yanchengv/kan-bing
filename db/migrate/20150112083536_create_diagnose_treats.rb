class CreateDiagnoseTreats < ActiveRecord::Migration
  def change
    create_table :diagnose_treats do |t|
      t.string :name
      t.integer :doctor_id,limit:8
      t.integer :patient_id,limit:8
      t.datetime :create_time
      t.string  :doctor_name
      t.timestamps
    end
  end
end
