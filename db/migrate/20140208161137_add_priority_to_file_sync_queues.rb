class AddPriorityToFileSyncQueues < ActiveRecord::Migration
  def change
    add_column :file_sync_queues, :priority, :integer
  end
end
