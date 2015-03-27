class AddColumnsToInspectionUltrasounds < ActiveRecord::Migration
  def change
    add_column :inspection_ultrasounds, :clinic_no, :string
    add_column :inspection_ultrasounds, :hospitalized_no, :string
  end
end
