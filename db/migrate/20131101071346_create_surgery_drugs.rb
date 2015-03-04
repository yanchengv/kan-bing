class CreateSurgeryDrugs < ActiveRecord::Migration
  def change
    create_table :surgery_drugs do |t|
      t.integer :surgery_id
      t.string :drug_name
      t.string :drug_unit
      t.decimal :drug_dosage
      t.datetime :drug_time

      t.timestamps
    end
  end
end
