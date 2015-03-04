class CreateModalityDevices < ActiveRecord::Migration
  def change
    create_table :modality_devices do |t|
      t.string :station_name
      t.string :station_aet
      t.string :modality

      t.timestamps
    end
  end
end
