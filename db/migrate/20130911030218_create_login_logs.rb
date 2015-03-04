class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.string :user_name
      t.string :ip_address
      t.datetime :login_time

      t.timestamps
    end
  end
end
