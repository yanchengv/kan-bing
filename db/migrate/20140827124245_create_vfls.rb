class CreateVfls < ActiveRecord::Migration
  def change
    create_table :vfls do |t|
      t.integer :patient_id,limit:8
      t.string :measure_value
      t.datetime :measure_time
      t.string :mdevice
      t.boolean :is_true

      t.timestamps
    end
  end
end
