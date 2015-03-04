class RenameTypeToCodeInMimasDataSyncQueue < ActiveRecord::Migration
  def change
    rename_column :mimas_data_sync_queues, :type, :code
  end
end
