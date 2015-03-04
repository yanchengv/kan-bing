class AddMobileTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_token, :string
    add_index :users, :mobile_token
  end
end
