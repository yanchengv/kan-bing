class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version_num
      t.string :url
      t.datetime :update_time

      t.timestamps
    end
  end
end
