class AddIsDefaultToUsersWorkspaces < ActiveRecord::Migration
  def change
    add_column :users_workspaces, :is_default, :boolean, :default => false
  end
end
