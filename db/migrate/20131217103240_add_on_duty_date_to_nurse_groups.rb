class AddOnDutyDateToNurseGroups < ActiveRecord::Migration
  def change
    remove_column :nurse_groups, :nurse_id, :integer
    add_column :nurse_groups, :on_duty_date, :date
    add_column :nurse_groups, :on_duty_of_week, :integer
  end
end
