class CreateSurgeryDrugDosages < ActiveRecord::Migration
  def change
    create_table :surgery_drug_dosages do |t|
      t.string :drug_name
      t.string :drug_no
      t.decimal :usage_amount
      t.string :quantity_per
      t.string :created_by
      t.string :updated_by
      t.integer :surgery_id

      t.timestamps
    end
  end
end
