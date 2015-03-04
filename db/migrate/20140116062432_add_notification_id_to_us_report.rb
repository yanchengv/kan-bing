class AddNotificationIdToUsReport < ActiveRecord::Migration
  def change
    add_column :us_reports, :notification_id, :integer
  end
end
