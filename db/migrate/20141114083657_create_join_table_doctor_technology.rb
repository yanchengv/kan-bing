class CreateJoinTableDoctorTechnology < ActiveRecord::Migration
  def change
    create_join_table :doctors, :skills do |t|
      # t.index [:doctor_id, :technology_id]
      # t.index [:technology_id, :doctor_id]
      t.integer :doctor_id ,:limit => 8
      t.integer :skill_id
      t.string :doctor_name ,:limit => 8
      t.string :skill_name
      
    end
  end
end
