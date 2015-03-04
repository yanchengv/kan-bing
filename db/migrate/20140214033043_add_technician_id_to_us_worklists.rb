class AddTechnicianIdToUsWorklists < ActiveRecord::Migration
  def change
    add_column :us_worklists, :technician_id,  :integer ,:limit => 8
  end
end
