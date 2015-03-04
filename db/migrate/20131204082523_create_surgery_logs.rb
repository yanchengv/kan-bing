class CreateSurgeryLogs < ActiveRecord::Migration
  def change
    create_table :surgery_logs  do |t|
      t.integer :surgery_id
      t.string :surgery_name
      t.integer :patient_id
      t.string :patient_name
      t.string :operate_action
      t.integer :operate_by_id
      t.string :operate_by_name
      t.string :msg_url

      t.timestamps
    end
  end
end
