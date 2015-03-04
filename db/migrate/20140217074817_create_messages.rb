class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text     "content"
      t.integer  "channel_id"
      t.integer  "user_id",:limit => 8

      t.timestamps
    end
  end
end
