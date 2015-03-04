class CreateBloodOxygens < ActiveRecord::Migration
  def change
    create_table :blood_oxygens do |t|
      t.integer :patient_id,limit:8
      t.string :pulse_rate
      t.string :o_saturation
      t.string :pi
      t.date :measure_time

      t.timestamps
    end
  end
end
