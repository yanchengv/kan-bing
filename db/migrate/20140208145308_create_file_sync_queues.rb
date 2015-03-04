class CreateFileSyncQueues < ActiveRecord::Migration
  def change
    create_table :file_sync_queues do |t|
      t.string :fileid
      t.datetime :starttime
      t.string :md5
      t.string :suffix

      t.timestamps
    end
  end
end
