class AddTwoColumnsToEduVideos < ActiveRecord::Migration
  def change
    add_column :edu_videos, :hospital_id, :integer, :limit => 8
    add_column :edu_videos, :department_id, :integer, :limit => 8
  end
end
