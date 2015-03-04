class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :note_id , :limit => 8
      t.integer :from_user_id, :limit => 8
      t.string :from_user_name
      t.integer :share_user_id, :limit => 8
      t.string :share_user_name
      t.string :share_type
      t.string :link

      t.timestamps
    end

    add_index :shares, :note_id
    add_index :shares, :from_user_id
    add_index :shares, :share_user_id
  end
end
