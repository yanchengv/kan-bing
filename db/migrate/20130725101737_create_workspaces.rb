class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.string :name, null: false
      t.string :desc
      t.string :icon
      t.string :default_view_panel
      t.text :menu
      t.text :shortcut

      t.timestamps
    end
  end
end
