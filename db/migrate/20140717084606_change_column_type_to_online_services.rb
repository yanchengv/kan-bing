class ChangeColumnTypeToOnlineServices < ActiveRecord::Migration
  def change
    rename_column :online_services, :type, :service_type
  end
end
