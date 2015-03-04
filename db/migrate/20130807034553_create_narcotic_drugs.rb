class CreateNarcoticDrugs < ActiveRecord::Migration
  def change
    create_table :narcotic_drugs do |t|
      t.string :drug_code
      t.string :name
      t.string :spell_code
      t.string :product_name
      t.string :english_name
      t.string :category
      t.string :dosage_forms
      t.string :quantity_per
      t.text :description
      t.timestamps
    end
  end
end
