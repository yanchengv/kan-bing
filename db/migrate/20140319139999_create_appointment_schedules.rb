class CreateAppointmentSchedules < ActiveRecord::Migration
    def change
      create_table :appointment_schedules, :id => false do |t|
        t.integer :id, :limit => 8
        t.integer :doctor_id, :limit => 8
        t.date :schedule_date
        t.time :start_time
        t.time :end_time
        t.integer :avalailbecount
        t.integer :status ,:default => 1
        t.integer :remaining_num
        t.timestamps
      end
      execute "ALTER TABLE appointment_schedules ADD PRIMARY KEY (id);"
    end

   #def self.down
   #  drop_table :appointment_schedules
   #end


end
