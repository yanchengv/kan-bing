class AddColumnsToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors,:verify_code,:string
    add_column :doctors,:is_activated,:integer ,:default => 0
  end
end
