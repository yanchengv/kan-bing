class AddTechnicianIdIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :patient_id
    add_index :users, :doctor_id
    add_index :users, :nurse_id
    add_index :users, :manager_id
    add_index :users, :technician_id
  end
end
