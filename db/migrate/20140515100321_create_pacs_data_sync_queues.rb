class CreatePacsDataSyncQueues < ActiveRecord::Migration
  def change
    create_table :pacs_data_sync_queues do |t|
      t.integer :task_id
      t.integer :super_task_id
      t.string :type
      t.string :content
      t.string :status

      t.timestamps
    end
  end
end
