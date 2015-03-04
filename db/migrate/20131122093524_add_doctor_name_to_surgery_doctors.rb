class AddDoctorNameToSurgeryDoctors < ActiveRecord::Migration
  def change
    add_column :surgery_doctors, :doctor_name, :string
  end
end
