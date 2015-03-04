class CreateSurgeryTypeOperatingRooms < ActiveRecord::Migration
  def change
    create_table :surgery_type_operating_rooms do |t|
      t.integer :surgery_id
      t.integer :operating_room_id

      t.timestamps
    end
  end
end
