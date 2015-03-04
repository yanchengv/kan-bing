class CreateBloodFats < ActiveRecord::Migration
  def change
    create_table :blood_fats do |t|
      t.integer :patient_id,:limit => 8
      t.string :total_cholesterol
      t.string :triglyceride
      t.string :high_lipoprotein
      t.string :low_lipoprotein
      t.date :measure_time

      t.timestamps
    end
  end
end
