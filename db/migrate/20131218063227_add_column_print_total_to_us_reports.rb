class AddColumnPrintTotalToUsReports < ActiveRecord::Migration
  def up
    add_column :us_reports, :print_total, :integer, :default => 0
  end

  def down
    remove_column :us_reports, :print_total
  end
end
