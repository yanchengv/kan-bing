class CreateEcgs < ActiveRecord::Migration
  def change
    create_table :ecgs do |t|
      t.string :ecg_img
      t.string :type
      t.datetime :measure_time
      t.string :ahdId
      t.string :mdevice
      t.boolean :is_true

      t.timestamps
    end
  end
end
