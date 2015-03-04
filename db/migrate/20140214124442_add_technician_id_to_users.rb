class AddTechnicianIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :technician_id, :integer,:limit => 8
  end
end
