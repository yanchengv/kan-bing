class CreateEduVideos < ActiveRecord::Migration
  def change
    create_table :edu_videos do |t|
      t.string :name
      t.string :content
      t.string :image_url
      t.string :video_url
      t.integer :doctor_id,:limit => 8
      t.string :doctor_name
      t.string :video_time

      t.timestamps
    end
  end
end
