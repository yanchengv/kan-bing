class AddMdeviceToGlucose < ActiveRecord::Migration
  def change
    add_column :blood_glucoses, :mdevice, :string
    remove_column :blood_glucoses, :measure_time
    add_column :blood_glucoses, :measure_time, :datetime
    #change_column :blood_glucoses, :measure_time,:datetime
    add_column :blood_oxygens,:mdevice,:string
    remove_column :blood_oxygens, :measure_time
    add_column :blood_oxygens, :measure_time, :datetime
    #change_column :blood_oxygens,:measure_time,:datetime
    add_column :blood_pressures,:mdevice,:string
    remove_column :blood_pressures, :measure_time
    add_column :blood_pressures, :measure_time, :datetime
    #change_column :blood_pressures,:measure_time,:datetime
     add_column :weights,:mdevice,:string
    add_column :weights,:height,:string
    add_column :weights,:bmi,:string
    add_column :weights,:bfr,:string
    add_column :weights,:smrwb,:string
    add_column :weights,:vfl,:string
    add_column :weights,:body_age,:string
    add_column :weights,:bme,:string
    remove_column :weights, :measure_time
    add_column :weights, :measure_time, :datetime
    #change_column :weights,:measure_time,:datetime

  end
end
