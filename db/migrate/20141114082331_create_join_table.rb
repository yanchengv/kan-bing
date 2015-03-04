class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :hospitals, :skills do |t|
      # t.index [:hospital_id, :technology_id]
      # t.index [:technology_id, :hospital_id]
      t.integer :hospital_id ,:limit => 8
      t.integer :skill_id
      t.string  :hospital_name 
      t.string  :skill_name
    end
  end
end
