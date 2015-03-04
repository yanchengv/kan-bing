class AddColumnIsCheckedToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors,:is_checked,:integer
  end
end
