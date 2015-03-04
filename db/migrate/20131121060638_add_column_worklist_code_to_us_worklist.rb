class AddColumnWorklistCodeToUsWorklist < ActiveRecord::Migration
  def up
    add_column :us_worklists, :worklist_code, :string
  end

  def down
    remove_column  :us_worklists, :worklist_code
  end
end
