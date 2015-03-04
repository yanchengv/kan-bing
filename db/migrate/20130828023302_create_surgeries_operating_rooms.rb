class CreateSurgeriesOperatingRooms < ActiveRecord::Migration
  def change
    create_table :surgeries_operating_rooms do |t|
      t.integer :surgery_id, :null => false ,:unique => true
      t.integer :operating_room_id, :null => false
      t.integer :anesthesia_doctor_id
      t.integer :arranger_doctor_id
      t.datetime :started_at
      t.datetime :end_at

      t.timestamps
    end
    #execute <<-SQL
    #    CREATE TRIGGER my_trigger
    #SQL
  end
end
