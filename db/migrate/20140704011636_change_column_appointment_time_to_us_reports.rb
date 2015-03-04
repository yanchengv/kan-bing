class ChangeColumnAppointmentTimeToUsReports < ActiveRecord::Migration
  def up
    change_column :us_reports, :appointment_time, :datetime
  end

  def down
    change_column :us_reports, :appointment_time, :date
  end
end
