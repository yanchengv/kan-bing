class AddColumnViewPermissionToEduVideo < ActiveRecord::Migration
  def change
    add_column :edu_videos, :view_permission, :string
  end
end
