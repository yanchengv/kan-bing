class CreateDepartmentsManagers < ActiveRecord::Migration
  def change
    create_table :departments_managers do |t|
      t.integer :department_id, limit: 8
      t.integer :manager_id
      t.timestamps
    end
  end
end
