class AddColumnLogDetailToSurgeryLog < ActiveRecord::Migration
  def up
    add_column :surgery_logs, :log_detail, :text
  end

  def down
    remove_column :surgery_logs, :log_detail
  end
end
