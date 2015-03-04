class AddIsSureToBlood < ActiveRecord::Migration
  def change
    add_column :blood_pressures,:is_sure,:boolean,:default =>true
    add_column :blood_glucoses,:is_sure,:boolean,:default =>true
    add_column :blood_oxygens,:is_sure,:boolean,:default =>true
    add_column :weights,:is_sure,:boolean,:default =>true
    add_column :blood_fats,:is_sure,:boolean,:default =>true
    add_column :patients,:scan_code,:string
    add_column :patients,:height,:string
  end
end


