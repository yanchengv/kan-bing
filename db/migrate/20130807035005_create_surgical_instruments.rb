class CreateSurgicalInstruments < ActiveRecord::Migration
  def change
    create_table :surgical_instruments do |t|
      t.string :equipment_code
      t.string :name
      t.string :spell_code
      t.string :product_name
      t.string :english_name
      t.string :category
      t.text :description
      t.timestamps
    end
  end
end
