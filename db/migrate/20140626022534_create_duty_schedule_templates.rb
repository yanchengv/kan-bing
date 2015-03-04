class CreateDutyScheduleTemplates < ActiveRecord::Migration
  def change
    create_table :duty_schedule_templates, :id=>false do |t|
      t.integer :id, :limit=> 8
      t.integer :doctor_id, :limit=>8
      t.string :doctor_name
      t.integer :modality_device_id
      t.string :station_aet
      t.string :mon
      t.string :tue
      t.string :wed
      t.string :thu
      t.string :fri
      t.string :sat
      t.string :sun

      t.timestamps
    end
    execute "ALTER TABLE duty_schedule_templates ADD PRIMARY KEY (id);"
  end
end
