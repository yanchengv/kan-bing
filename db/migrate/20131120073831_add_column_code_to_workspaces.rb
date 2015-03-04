class AddColumnCodeToWorkspaces < ActiveRecord::Migration
  def up
    add_column :workspaces, :code, :string
  end

  def down
    remove_column  :workspaces, :code
  end
end
