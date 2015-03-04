class AddIsSupportMobileToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :is_support_mobile, :boolean  , :default => false
  end
end
