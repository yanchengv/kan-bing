class AddColumnsToTreatmentRelationship < ActiveRecord::Migration
  def change
    add_column :treatment_relationships, :d_province_id, :integer, :limit => 8
    add_column :treatment_relationships, :d_city_id, :integer, :limit => 8
    add_column :treatment_relationships, :d_hospital_id, :integer, :limit => 8
    add_column :treatment_relationships, :d_department_id, :integer, :limit => 8
    add_column :treatment_relationships, :p_province_id, :integer, :limit => 8
    add_column :treatment_relationships, :p_city_id, :integer, :limit => 8
    add_column :treatment_relationships, :p_hospital_id, :integer, :limit => 8
    add_column :treatment_relationships, :p_department_id, :integer, :limit => 8

    add_column :doctor_friendships, :province1_id, :integer, :limit => 8
    add_column :doctor_friendships, :city1_id, :integer, :limit => 8
    add_column :doctor_friendships, :hospital1_id, :integer, :limit => 8
    add_column :doctor_friendships, :department1_id, :integer, :limit => 8
    add_column :doctor_friendships, :province2_id, :integer, :limit => 8
    add_column :doctor_friendships, :city2_id, :integer, :limit => 8
    add_column :doctor_friendships, :hospital2_id, :integer, :limit => 8
    add_column :doctor_friendships, :department2_id, :integer, :limit => 8
  end
end
