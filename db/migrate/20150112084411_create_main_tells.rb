class CreateMainTells < ActiveRecord::Migration
  def change
    create_table :main_tells do |t|
      t.text :tell_content
      t.integer :doctor_id,limit:8
      t.integer :patient_id,limit:8
      t.integer :diagnose_treat_id
      t.string :teller
      t.string  :doctor_name
      t.datetime :create_time

      t.timestamps
    end
  end
end
