class CreateMimasDataSyncQueues < ActiveRecord::Migration
  def change
    create_table :mimas_data_sync_queues do |t|
      t.integer :foreign_key,:limit=>8
      t.string :table_name
      t.integer :type
      t.string :contents
      t.timestamps
    end
  end
end
