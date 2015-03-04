class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :patient_id,limit:8
      t.string :weight_value
      t.date :measure_time
      t.timestamps
    end
  end
end
