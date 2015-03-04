class AddColumnsPatientIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :patient_id, :integer, :limit => 8
  end
end
