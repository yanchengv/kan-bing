class CreateScheduleTemplates < ActiveRecord::Migration
  def change
    create_table :schedule_templates, :id => false  do |t|
      t.integer :id, :limit => 8
      t.integer :doctor_id, :limit => 8
      t.integer :dayofweek
      t.time :start_time
      t.time :end_time
      t.integer :number

      t.timestamps
    end
    execute "ALTER TABLE schedule_templates ADD PRIMARY KEY (id);"
    add_index :schedule_templates,:doctor_id
    add_index :schedule_templates,:dayofweek
  end
end
