class AddOperatingRoomIdToSurgicalInstruments < ActiveRecord::Migration
  def change
    add_column :surgical_instruments, :operating_room_id, :integer
  end
end
