class CreateItemUsers < ActiveRecord::Migration
  def change
    create_table :item_users do |t|
      t.integer :user_id ,:limit => 8
      t.integer :item_id

      t.timestamps
    end
  end
end
