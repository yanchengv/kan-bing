class CreateDoctorFriendships < ActiveRecord::Migration
  def change
    create_table :doctor_friendships do |t|
      t.integer "doctor1_id"
      t.integer "doctor2_id"

      t.timestamps
    end
    add_index  :doctor_friendships, :doctor1_id
    add_index  :doctor_friendships, :doctor2_id
  end
end
