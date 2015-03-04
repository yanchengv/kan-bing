class ChangeColumnTypeInEcgImg < ActiveRecord::Migration
  def change
    change_column :ecgs, :ecg_img, :text
    rename_column :ecgs, :type, :device_type
    add_column :ecgs, :int_ecg_img, :text
    add_column :ecgs, :bit_ecg_img, :text
    add_column :ecgs, :patient_id, :integer,limit:8
  end
end
