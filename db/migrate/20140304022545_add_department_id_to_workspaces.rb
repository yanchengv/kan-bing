class AddDepartmentIdToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :department_id, :integer
  end
end
