class AddNameToRecordedVideo < ActiveRecord::Migration
  def change
    add_column :recorded_videos, :name, :string
  end
end
