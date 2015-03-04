class AddColumnReportTypeToUsReport < ActiveRecord::Migration
  def up
    add_column :us_reports, :report_type, :integer
    add_index :us_reports, :report_type
  end

  def down
    remove_column :us_reports, :report_type
  end
end
