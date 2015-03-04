class CreateSurgicalInstrumentInstances < ActiveRecord::Migration
  def change
    create_table :surgical_instrument_instances do |t|
      t.integer :surgical_instrument_id
      t.integer :operating_room_id
      t.string :equipment_code
      t.string :name
      t.string :spell_code
      t.string :product_name
      t.string :english_name
      t.string :type

      t.timestamps
    end
  end
end
