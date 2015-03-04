class AddChildIdToInspetionReports < ActiveRecord::Migration
  def change
    add_column :inspection_reports, :child_id, :integer,:limit => 8
    add_column :inspection_reports, :upload_doctor_id, :integer,:limit => 8
    add_column :inspection_reports, :upload_doctor_name, :string
  end
end
