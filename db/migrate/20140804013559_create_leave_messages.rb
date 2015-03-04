class CreateLeaveMessages < ActiveRecord::Migration
  def change
    create_table :leave_messages do |t|
      t.integer :user_id,:limit => 8
      t.string :owner
      t.string :title
      t.text :content
      t.string :message_type
      t.integer :view_count,:default => 0
      t.integer :like_count,:default => 0
      t.integer :reply_count,:default => 0

      t.timestamps
    end
    add_index :leave_messages,:user_id
  end
end
