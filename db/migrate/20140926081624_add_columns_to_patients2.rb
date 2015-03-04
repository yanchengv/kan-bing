class AddColumnsToPatients2 < ActiveRecord::Migration
  def change
    add_column :patients, :hospital_id , :integer, :limit => 8
    add_column :patients, :department_id, :integer, :limit => 8
  end
end
