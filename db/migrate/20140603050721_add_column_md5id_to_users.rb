class AddColumnMd5idToUsers < ActiveRecord::Migration
  def change
    add_column :users, :md5id, :string
  end
end
