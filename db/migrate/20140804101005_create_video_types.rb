class CreateVideoTypes < ActiveRecord::Migration
  def change
    create_table :video_types do |t|
      t.string :type_name

      t.timestamps
    end
    remove_column :edu_videos, :video_type
    add_column :edu_videos, :video_type_id, :integer
    add_index :edu_videos, :video_type_id
  end
end
