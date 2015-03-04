class ChangeTypeForPacsDataSyncQueue < ActiveRecord::Migration
  def change
    rename_column :pacs_data_sync_queues, :type, :pacs_type
  end
end
