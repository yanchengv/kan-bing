class CreateBloodGlucoses < ActiveRecord::Migration
  def change
    create_table :blood_glucoses do |t|
      t.integer :patient_id,:limit => 8
      t.string :measure_value
      t.date :measure_date
      t.time :measure_time
      t.timestamps
    end
  end
end
