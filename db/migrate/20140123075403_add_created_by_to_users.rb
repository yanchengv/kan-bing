class AddCreatedByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :created_by, :string
    add_column :users, :level, :integer
    add_column :users, :manager_id, :integer
  end
end
