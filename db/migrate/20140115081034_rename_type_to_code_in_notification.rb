class RenameTypeToCodeInNotification < ActiveRecord::Migration
  def change
    rename_column :notifications , :type, :code
  end
end
