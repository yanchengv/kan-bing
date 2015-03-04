class AddSurgeryIdToRecordedVideo < ActiveRecord::Migration
  def change
    add_column :recorded_videos, :surgery_id, :integer
  end
end
