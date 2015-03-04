class ChangeColumnsTypeDoctors < ActiveRecord::Migration
  def change
    change_column :doctors, :hospital_id, :integer, :limit => 8
    change_column :doctors, :department_id, :integer, :limit => 8

    change_column :departments, :hospital_id,:integer,:limit => 8
  end
end
