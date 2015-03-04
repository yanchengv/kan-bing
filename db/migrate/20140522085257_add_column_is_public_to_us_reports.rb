class AddColumnIsPublicToUsReports < ActiveRecord::Migration
  def up
    add_column :us_reports, :is_public, :integer, :default => 0
  end

  def down
    remove_column :us_reports, :is_public
  end
end
