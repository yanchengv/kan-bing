class AddDescriptionToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :description, :string
    remove_column :notifications, :code
    add_column :notifications, :type, :integer
    add_index :notifications, :user_id
  end
end
