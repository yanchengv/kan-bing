class AddMobileMenuToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :mobile_menu, :text
  end
end
