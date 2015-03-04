class ChangeClolumnToTechnoicians < ActiveRecord::Migration
  def change
    change_column :technicians, :hospital_id, :integer, :limit =>8
    change_column :technicians, :department_id, :integer, :limit => 8
  end
end
