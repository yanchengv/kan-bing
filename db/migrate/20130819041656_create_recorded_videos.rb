class CreateRecordedVideos < ActiveRecord::Migration
  def change
    create_table :recorded_videos do |t|
      t.integer :video_source_id
      t.string :video_id
      t.timestamp :record_time
      t.integer :duration
      t.integer :status

      t.timestamps
    end
  end
end
