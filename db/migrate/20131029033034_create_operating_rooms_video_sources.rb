class CreateOperatingRoomsVideoSources < ActiveRecord::Migration
  def change
    create_table :operating_rooms_video_sources do |t|
      t.integer :operating_room_id
      t.integer :video_source_id
      t.string :type
      t.timestamps
    end
  end
end
