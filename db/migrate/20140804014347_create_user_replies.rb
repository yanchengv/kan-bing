class CreateUserReplies < ActiveRecord::Migration
  def change
    create_table :user_replies do |t|
      t.integer :user_id,:limit => 8
      t.string :reply_user
      t.integer :leave_message_id
      t.text :reply_content

      t.timestamps
    end
    add_index :user_replies,:user_id
    add_index :user_replies,:leave_message_id
  end
end
