class CreateFileSyncResults < ActiveRecord::Migration
  def change
    create_table :file_sync_results do |t|
      t.string :fileid
      t.datetime :starttime
      t.datetime :endtime
      t.string :md5
      t.string :suffix

      t.timestamps
    end
  end
end
