class AddColumnToInspectionReports < ActiveRecord::Migration
  def change
    add_column :inspection_reports, :doctor, :string
    add_column :inspection_reports, :hospital, :string
    add_column :inspection_reports, :department, :string
    add_column :inspection_reports, :checked_at, :date
  end
end
