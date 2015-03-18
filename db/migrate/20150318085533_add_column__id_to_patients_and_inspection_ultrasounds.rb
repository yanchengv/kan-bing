class AddColumnIdToPatientsAndInspectionUltrasounds < ActiveRecord::Migration
  def change
    add_column :patients, :_id,:string
    add_column :inspection_ultrasounds, :_id,:string
  end
end
