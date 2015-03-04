class AddColumnVideoTypeToEduVideo < ActiveRecord::Migration
  def change
    add_column :edu_videos, :video_type, :string
  end
end
