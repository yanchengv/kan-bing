class CreateArchiveQueues < ActiveRecord::Migration
  def change
    create_table :archive_queues do |t|
      t.integer :upload_user_id, :limit => 8 #
      t.string :upload_user_name #
      t.string :parent_type
      t.string :child_type
      t.string :filename
      t.string :filesize
      t.string :extname
      t.integer :hospital_id, :limit => 8
      t.string :hospital_name
      t.integer :department_id, :limit => 8
      t.string :department_name
      t.integer :doctor_id, :limit => 8
      t.string :doctor_name
      t.integer :patient_id, :limit => 8
      t.string :patient_name
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
