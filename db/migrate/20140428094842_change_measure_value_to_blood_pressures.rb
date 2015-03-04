class ChangeMeasureValueToBloodPressures < ActiveRecord::Migration
  change_table :blood_pressures do |t|
    t.rename  :measure_value,:systolic_pressure
    t.string  :diastolic_pressure
  end
end
