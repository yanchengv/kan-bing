class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.integer :owner_id,:limit => 8
      t.integer :patient_id,:limit => 8
      t.string :name
      t.text :init_info
      t.text :purpose
      t.string :status
      t.string :status_description
      t.string :number
      t.datetime :start_time
      t.datetime :schedule_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
