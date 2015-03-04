class AddColumnOperationFrequenceToModalityDevices < ActiveRecord::Migration
  def up
    add_column :modality_devices, :operation_frequence, :string
  end

  def down
    remove_column  :modality_devices, :operation_frequence
  end
end







