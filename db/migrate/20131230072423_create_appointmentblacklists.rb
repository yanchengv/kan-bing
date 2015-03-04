#author:wangfang
class CreateAppointmentblacklists < ActiveRecord::Migration
  def change
    create_table :appointmentblacklists do |t|
      t.integer :user_id
      t.datetime :unlock_time
      t.timestamps
    end
  end
end
