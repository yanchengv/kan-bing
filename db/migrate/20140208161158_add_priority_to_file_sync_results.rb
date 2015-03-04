class AddPriorityToFileSyncResults < ActiveRecord::Migration
  def change
    add_column :file_sync_results, :priority, :integer
  end
end
