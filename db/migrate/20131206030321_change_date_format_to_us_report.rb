class ChangeDateFormatToUsReport < ActiveRecord::Migration
  def up
    change_column :us_reports, :check_start_time, :datetime
    change_column :us_reports, :check_end_time, :datetime
  end

  def down
    change_column :us_reports, :check_start_time, :date
    change_column :us_reports, :check_end_time, :date
  end
end
