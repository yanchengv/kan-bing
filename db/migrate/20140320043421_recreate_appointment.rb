class RecreateAppointment < ActiveRecord::Migration
  def change
    drop_table :appointments
    create_table :appointments, :id => false  do |t|
      t.integer :id, :limit => 8
      t.integer :patient_id, :limit => 8
      t.integer :doctor_id, :limit => 8
      t.date    :appointment_day
      t.time :start_time
      t.time :end_time
      t.integer :status
      t.integer :hospital_id
      t.integer :department_id
      t.integer :appointment_schedule_id , :limit => 8
      t.integer :dictionary_id
      t.timestamps
    end
    execute "ALTER TABLE appointments ADD PRIMARY KEY (id);"
  end
end
