class CreateSurgeryDoctors < ActiveRecord::Migration
  def change
    create_table :surgery_doctors do |t|
      t.integer :surgery_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
