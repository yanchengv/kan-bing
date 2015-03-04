class AddColumnDepartmentIdToModalityDevice < ActiveRecord::Migration
  def up
    add_column :modality_devices, :department_id, :integer
  end

  def down
    remove_column  :modality_devices, :department_id
  end
end
