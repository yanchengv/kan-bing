class AddColumnsHospitalIdNameToUsReports < ActiveRecord::Migration
  def up
    add_column :us_reports, :hospital_id, :integer
    add_column :us_reports, :hospital_name, :string


    add_column :mimas_data_sync_queues, :is_processing, :boolean, :default => false
    add_column :mimas_data_sync_queues, :is_finallevel, :boolean, :default => false
    add_column :mimas_data_sync_queues, :file_id, :string
    add_column :mimas_data_sync_queues, :priority, :integer, :default => 0
  end

  def down
    remove_column :us_reports, :hospital_id
    remove_column :us_reports, :hospital_name


    remove_column :mimas_data_sync_queues, :is_processing
    remove_column :mimas_data_sync_queues, :is_finallevel
    remove_column :mimas_data_sync_queues, :file_id
    remove_column :mimas_data_sync_queues, :priority
  end
end
