class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users,:nick_name,:string
    add_column :users,:verification_code,:string
    add_column :users,:real_name,:string
    add_column :users,:registered_hospital,:string
  end
end
