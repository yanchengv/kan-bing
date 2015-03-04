class AddColumnRelatedModelToSurgeryLog < ActiveRecord::Migration
  def up
    add_column :surgery_logs, :related_model, :string
  end

  def down
    remove_column :surgery_logs, :related_model
  end
end
