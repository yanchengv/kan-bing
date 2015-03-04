class CreateOperatingRooms < ActiveRecord::Migration
  def change
    create_table :operating_rooms do |t|
      t.string :name
      t.string :room_location
      t.string :cleanliness_level
      t.string :description
      t.string :categery
      t.string :spell_code
      t.string :ventilator
      t.string :anesthesia_machine
      t.string :specification
      t.string :note
      t.boolean :is_used ,:default => false
      t.text :configs

      t.timestamps
    end
  end
end
