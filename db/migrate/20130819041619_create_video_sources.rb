#encoding:utf-8
class CreateVideoSources < ActiveRecord::Migration
  def change
    create_table :video_sources  do |t|
      t.integer :sid        #标示视频源的唯一id
      t.string :name        #视频源名称
      t.string :address     #视频源地址
      t.string :video_id    #视频id  上一次录制的视频id，用来测试视频是否播放正常
      t.integer :state, :default => 0
      t.string  :pid
      t.timestamps
    end
    add_index :video_sources, :sid, :unique => true
  end
end
