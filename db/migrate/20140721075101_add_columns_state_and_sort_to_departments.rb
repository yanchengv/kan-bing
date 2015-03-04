class AddColumnsStateAndSortToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :state, :integer
    add_column :departments, :sort, :integer
  end
end
