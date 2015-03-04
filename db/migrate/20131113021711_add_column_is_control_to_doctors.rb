class AddColumnIsControlToDoctors < ActiveRecord::Migration
  def up
    add_column :doctors, :is_control, :boolean, :default => false
  end

  def down
    remove_column  :doctors, :is_control
  end
end
