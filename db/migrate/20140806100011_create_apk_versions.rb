class CreateApkVersions < ActiveRecord::Migration
  def change
    create_table :apk_versions do |t|
      t.string :version_num
      t.string :version_url
      t.text :description
      t.datetime :update_time

      t.timestamps
    end
  end
end
