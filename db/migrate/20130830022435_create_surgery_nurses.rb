class CreateSurgeryNurses < ActiveRecord::Migration
  def change
    create_table :surgery_nurses do |t|
      t.integer :surgery_id
      t.integer :nurse_id
      t.integer :appliance_nurse_id
      t.datetime :started_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
