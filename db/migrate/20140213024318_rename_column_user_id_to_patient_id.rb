class RenameColumnUserIdToPatientId < ActiveRecord::Migration
  def change
    rename_column :appointments, :user_id, :patient_id
    rename_column :appointmentblacklists, :user_id, :patient_id
  end
end
