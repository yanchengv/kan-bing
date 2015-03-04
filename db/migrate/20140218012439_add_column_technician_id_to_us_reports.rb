class AddColumnTechnicianIdToUsReports < ActiveRecord::Migration
    def change
      add_column :us_reports, :technician_id, :integer, :limit => 8
      add_index :us_reports, :technician_id
    end
end
