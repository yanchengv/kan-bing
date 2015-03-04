class CreateJoinTableGroupSkill < ActiveRecord::Migration
  def change
    create_join_table :groups, :skills do |t|
      t.index [:group_id, :skill_id]
    end

    create_table :doctors_groups, :id => false do |t|
      t.integer :group_id
      t.integer :doctor_id,:limit => 8
      t.integer :doctor_name
      t.integer :user_id,:limit => 8
      t.index [:group_id, :doctor_id]
    end

  end
end
