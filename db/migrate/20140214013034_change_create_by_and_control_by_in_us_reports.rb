class ChangeCreateByAndControlByInUsReports < ActiveRecord::Migration
  def change
    change_column :us_reports, :controller_by, :integer, :limit => 8
    change_column :us_quality_controls, :report_id , :integer, :limit => 8
    change_column :us_quality_controls, :operator_id , :integer, :limit => 8
    change_column :surgeries, :doctor_advice_id , :integer, :limit => 8
    change_column :patients, :p_user_id , :integer, :limit => 8
    change_column :surgery_logs, :operate_by_id , :integer, :limit => 8
  end
end
