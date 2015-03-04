class CreateUsReportDocLogs < ActiveRecord::Migration
  def change
    create_table :us_report_doc_logs do |t|
      t.integer :report_id, :limit => 8
      t.integer :doc_uuid, :limit => 8

      t.timestamps
    end
  end
end
