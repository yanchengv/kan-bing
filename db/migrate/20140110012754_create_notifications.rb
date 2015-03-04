class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, :null => false
      t.string :code, :null => false
      t.text :content
      t.datetime :start_time
      t.datetime :expired_time

      t.timestamps
    end
  end
end
