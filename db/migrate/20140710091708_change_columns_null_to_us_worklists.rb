class ChangeColumnsNullToUsWorklists < ActiveRecord::Migration
  def self.up
    change_column :us_worklists, :patient_ids, :string, :null => true
    change_column :us_worklists, :apply_doctor_id, :integer, :null => true, :limit => 8
    change_column :us_worklists, :source_code, :string, :null => true
    change_column :us_worklists, :examined_part_id, :integer, :null => true
    change_column :us_worklists, :examined_item_id, :integer, :null => true
  end

  def self.down
    change_column :us_worklists, :patient_ids, :string
    change_column :us_worklists, :apply_doctor_id, :integer, :limit => 8
    change_column :us_worklists, :source_code, :string
    change_column :us_worklists, :examined_part_id, :integer
    change_column :us_worklists, :examined_item_id, :integer
  end
end
