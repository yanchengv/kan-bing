#encoding:utf-8
class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name, :null => false
      t.string :spell_code
      t.string :credential_type
      t.string :credential_type_number
      t.string :gender, :null => false, :default => "男"
      t.date :birthday, :null => false
      t.string :birthplace
      t.string :address
      t.string :nationality
      t.string :citizenship
      t.string :province
      t.string :county
      t.string :photo
      t.string :marriage
      t.string :mobile_phone#, :null => false
      t.string :home_phone
      t.string :home_address
      t.string :contact
      t.string :contact_phone
      t.string :home_postcode
      t.string :email
      t.string :introduction
      t.integer :hospital_id
      t.integer :department_id
      t.string :professional_title
      t.string :position
      t.date :hire_date
      t.string :certificate_number
      t.string :expertise
      t.string :degree
      t.integer :state

      t.timestamps
    end
    execute "ALTER TABLE doctors ADD PRIMARY KEY (id);"
    add_index :doctors, :name
    add_index :doctors, :spell_code
    add_index :doctors, :credential_type_number
    add_index :doctors, :gender
    add_index :doctors, :mobile_phone
    add_index :doctors, :hospital_id
    add_index :doctors, :department_id
    add_index :doctors, :professional_title
  end
end