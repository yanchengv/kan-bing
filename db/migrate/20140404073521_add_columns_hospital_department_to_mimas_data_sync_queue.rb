class AddColumnsHospitalDepartmentToMimasDataSyncQueue < ActiveRecord::Migration
  def change
    add_column :mimas_data_sync_queues, :hospital, :string
    add_column :mimas_data_sync_queues, :department, :string
  end
end
