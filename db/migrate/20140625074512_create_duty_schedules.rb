class CreateDutySchedules < ActiveRecord::Migration
  def change
    create_table :duty_schedules, :id=>false do |t|
      t.integer :id, :limit=> 8
      t.integer :doctor_id, :limit=> 8
      t.string :doctor_name
      t.integer :department_id, :limit=> 8
      t.string :department_name
      t.integer :modality_device_id
      t.string :station_aet
      t.date :work_time
      t.string :duty_type
      t.string :desc

      t.timestamps
    end
    execute "ALTER TABLE duty_schedules ADD PRIMARY KEY (id);"
  end
end
