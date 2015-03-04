#author:wangfang
class CreateAppointmentAvalibles < ActiveRecord::Migration
  def change
    create_table :appointment_avalibles do |t|
      t.integer :avalibledoctor_id
      t.date :avalibleappointmentdate
      t.integer :avalibletimeblock
      t.integer :avaliblecount
      t.integer :schedule_id
      t.integer :dictionary_id
      t.timestamps
    end
  end
end
