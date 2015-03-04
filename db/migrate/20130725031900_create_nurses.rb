#encoding:utf-8
class CreateNurses < ActiveRecord::Migration
  def change
    create_table :nurses, :id => false do |t|
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
      t.string :mobile_phone, :null => false
      t.string :home_phone
      t.string :home_address
      t.string :contact
      t.string :contact_phone
      t.string :home_postcode
      t.string :email
      t.string :introduction
      t.string :professional_title
      t.integer :hospital_id
      t.integer :department_id
      t.date :hire_date
      t.string :certificate_number
      t.string :degree

      t.timestamps
    end
    execute "ALTER TABLE nurses ADD PRIMARY KEY (id);"
    add_index :nurses, :name
    add_index :nurses, :spell_code
    add_index :nurses, :credential_type_number
    add_index :nurses, :gender
    add_index :nurses, :mobile_phone
    add_index :nurses, :hospital_id
    add_index :nurses, :department_id
    add_index :nurses, :professional_title
  end
end