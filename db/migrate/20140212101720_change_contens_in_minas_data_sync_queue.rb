class ChangeContensInMinasDataSyncQueue < ActiveRecord::Migration
  def up
    change_column :mimas_data_sync_queues, :contents, :text
  end

  def down
    change_column :mimas_data_sync_queues, :contents, :string
  end
end
