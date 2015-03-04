class AddColumnsToDoctorsAndHospital < ActiveRecord::Migration
  def up
    add_column :doctors, :hospital_name, :string
    add_column :doctors, :department_name, :string
    add_column :doctors, :province_name, :string
    add_column :doctors, :city_name, :string
    add_column :doctors, :rewards, :string

    add_column :hospitals, :province_id, :integer
    add_column :hospitals, :province_name, :string
    add_column :hospitals, :city_id, :integer
    add_column :hospitals, :city_name, :string
    add_column :hospitals, :key_departments, :string
    add_column :hospitals, :operation_mode, :string
    add_column :hospitals, :email, :string
    add_column :hospitals, :hospital_site, :string
    add_column :hospitals, :fax_number, :string

  end

  def down
    remove_column :doctors, :hospital_name
    remove_column :doctors, :department_name
    remove_column :doctors, :province_name
    remove_column :doctors, :city_name
    remove_column :doctors, :rewards

    remove_column :hospitals, :province_id
    remove_column :hospitals, :province_name
    remove_column :hospitals, :city_id
    remove_column :hospitals, :city_name
    remove_column :hospitals, :key_departments
    remove_column :hospitals, :operation_mode
    remove_column :hospitals, :email
    remove_column :hospitals, :hospital_site
    remove_column :hospitals, :fax_number
  end
end
