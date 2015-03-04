class CreateDoctorLists < ActiveRecord::Migration
  def change
    create_table :doctor_lists do |t|
      t.integer :docmember_id,:limit => 8
      t.integer :consultation_id
      t.boolean :confirmed, :default => false
      t.timestamps
    end
    add_index :doctor_lists,:consultation_id
    add_index :doctor_lists,[:docmember_id,:consultation_id],:unique => true
  end
end
