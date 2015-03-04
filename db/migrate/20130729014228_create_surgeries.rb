class CreateSurgeries < ActiveRecord::Migration
  def change
    create_table :surgeries  do |t|
      t.string :name
      t.integer :department_id
      t.string :surgery_level
      t.boolean :is_minimally_invasive
      t.boolean :is_pollute
      t.boolean :is_isolation
      t.boolean :is_infect
      t.string :nurse_visited_uids
      t.string :anaesthesia_visited_uids
      t.datetime :schedule_time
      t.decimal :duration
      t.integer :inpatient_record_id
      t.integer :patient_id
      t.text :preoperative_diagnosis
      t.integer :master_doctor_id
      t.string :assistant_doctor_id
      t.boolean :is_emgency
      t.integer :doctor_advice_id
      t.datetime :apply_time, :default => Time.now
      t.integer :apply_doctor_id
      t.text :notes
      t.integer :arranger_doctor_id
      t.integer :anesthesia_doctor_id
      t.datetime :surgery_time
      t.integer :operating_room_id
      t.integer :anaesthesia_plan_id
      #t.string :anaesthesia_view_id
      t.integer :patrol_nurse_id
      t.integer :appliance_nurse_id
      t.datetime :actual_start_time
      t.datetime :actual_end_time
      t.string :surgery_status
      t.boolean :is_ended
      t.string :ended_reason

      t.timestamps
    end
  end
end
