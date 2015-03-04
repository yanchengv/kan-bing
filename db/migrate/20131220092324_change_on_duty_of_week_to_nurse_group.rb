class ChangeOnDutyOfWeekToNurseGroup < ActiveRecord::Migration
  def change
    rename_column  :nurse_groups ,:on_duty_of_week, :on_duty_of_month
  end
end
