class AddColumnDepartmentTypeInDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :department_type, :integer
  end
end
