class CreateDoctorOrders < ActiveRecord::Migration
  def change
    create_table :doctor_orders do |t|
      t.datetime :create_time
      t.datetime :start_time
      t.datetime :valid_time
      t.integer :doctor_id ,limit:8
      t.integer :patient_id ,limit:8
      t.integer :diagnose_treat_id
      t.string :executor
      t.text :content
      t.string :order_type
      t.text :according
      t.string  :doctor_name
      t.timestamps
    end
  end
end
