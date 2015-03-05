class AddColumnsDoctors2patients < ActiveRecord::Migration
  def change
    add_column :doctors, :organization_id, :integer, :limit => 8
    add_column :patients, :organization_id, :integer, :limit => 8
  end
end
