class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users,:credential_type_number,:string
    add_column :users,:mobile_phone,:string
    add_column :users,:email,:string
  end
end
