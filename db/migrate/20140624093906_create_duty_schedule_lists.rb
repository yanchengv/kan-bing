class CreateDutyScheduleLists < ActiveRecord::Migration
  def change
    create_table :duty_schedule_lists, :id => false do |t|
      t.integer :id, :limit=> 8
      t.integer :doctor_id, :limit => 8
      t.string :doctor_name
      t.integer :department_id, :limit=> 8
      t.string :department_name
      t.integer :modality_device_id
      t.string :station_aet
      #t.integer :duty_schedule_id
      t.integer :year
      t.integer :month
      t.string :day1
      t.string :day2
      t.string :day3
      t.string :day4
      t.string :day5
      t.string :day6
      t.string :day7
      t.string :day8
      t.string :day9
      t.string :day10
      t.string :day11
      t.string :day12
      t.string :day13
      t.string :day14
      t.string :day15
      t.string :day16
      t.string :day17
      t.string :day18
      t.string :day19
      t.string :day20
      t.string :day21
      t.string :day22
      t.string :day23
      t.string :day24
      t.string :day25
      t.string :day26
      t.string :day27
      t.string :day28
      t.string :day29
      t.string :day30
      t.string :day31

      t.timestamps
    end
    execute "ALTER TABLE duty_schedule_lists ADD PRIMARY KEY (id);"
  end
end
