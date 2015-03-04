#encoding:utf-8
class CreateTechnicians < ActiveRecord::Migration
  def change
    create_table :technicians , :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name
      t.string :spell_code
      t.string :credential_type
      t.integer :credential_type_number
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
      t.string :mobile_phone
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
      t.string :type

      t.timestamps
    end
    execute "ALTER TABLE technicians ADD PRIMARY KEY (id);"
    add_index :technicians, :name
    add_index :technicians, :spell_code
    add_index :technicians, :credential_type_number
    add_index :technicians, :gender
    add_index :technicians, :mobile_phone
    add_index :technicians, :hospital_id
    add_index :technicians, :department_id
    add_index :technicians, :professional_title
  end
end
