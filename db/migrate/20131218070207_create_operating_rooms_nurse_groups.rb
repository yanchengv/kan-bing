class CreateOperatingRoomsNurseGroups < ActiveRecord::Migration
  def change
    create_table :operating_rooms_nurse_groups do |t|
      t.integer :operating_room_id
      t.integer :nurse_group_id
      t.date :on_duty_date
      t.integer :on_duty_of_week

      t.timestamps
    end
  end
end
