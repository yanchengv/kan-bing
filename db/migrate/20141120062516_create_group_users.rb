class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.integer :group_id, :null => false
      t.integer :user_id , :limit => 8
      t.integer :doctor_id ,:limit => 8
      t.string  :doctor_name
      t.timestamps
    end
  end
end
