class AddLoginResultToLoginLog < ActiveRecord::Migration
  def change
    add_column :login_logs, :login_result, :boolean
  end
end
