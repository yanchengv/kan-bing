#author:wangfang
class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :doctor_id
      t.date    :appointment_day
      t.integer :appointment_time
      t.string  :status
      t.integer :hospital_id
      t.integer :department_id
      t.integer :appointment_avalibleId
      t.timestamps
    end
  end
end
