class CreatePatientSurgeryRisks < ActiveRecord::Migration
  def change
    create_table :patient_surgery_risks do |t|
      t.integer :surgery_id
      t.integer :upper_limit
      t.integer :lower_limit
      t.float :risk_factor
      t.boolean :gender
      t.integer :habitus

      t.timestamps
    end
  end
end
