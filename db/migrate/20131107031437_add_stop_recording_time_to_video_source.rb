class AddStopRecordingTimeToVideoSource < ActiveRecord::Migration
  def change
    add_column :video_sources, :stop_recording_time, :integer ,:default => 0
  end
end
