class ChangeForeignKeyTypeLimit < ActiveRecord::Migration
  def change
    change_column :appointmentblacklists, :user_id, :integer, :limit => 8
    change_column :patients, :doctor_id, :integer, :limit => 8
    change_column :doctor_friendships, :doctor1_id, :integer, :limit => 8
    change_column :doctor_friendships, :doctor2_id, :integer, :limit => 8
    change_column :treatment_relationships, :doctor_id, :integer, :limit => 8
    change_column :treatment_relationships, :patient_id, :integer, :limit => 8
  end
end
