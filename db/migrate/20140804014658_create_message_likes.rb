class CreateMessageLikes < ActiveRecord::Migration
  def change
    create_table :message_likes do |t|
      t.integer :user_id, :limit => 8
      t.integer :leave_message_id

      t.timestamps
    end
    add_index :message_likes,:user_id
    add_index :message_likes,:leave_message_id
  end
end
