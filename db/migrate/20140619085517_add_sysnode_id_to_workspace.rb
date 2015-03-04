class AddSysnodeIdToWorkspace < ActiveRecord::Migration
  def change
    add_column :workspaces, :sysnode_id, :integer
    add_column :workspaces, :sysnode_name, :string
  end
end
