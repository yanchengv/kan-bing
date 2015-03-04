#encoding:utf-8
class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :name, null: false
      t.string :spell_code
      t.string :credential_type
      t.string :credential_type_number, null: false
      t.string :gender, null: false, default: '男'
      t.date :birthday
      t.string :birthplace
      t.string :address
      t.string :nationality
      t.string :citizenship
      t.string :province
      t.string :country
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
      t.string :qq
      t.string :weixin
      t.integer :level
      t.datetime :expired_time
      t.string :manager_number, null: false
      t.string :authorities
      t.string :created_by

      t.timestamps
    end
    add_index :managers, :name
    add_index :managers, :spell_code
    add_index :managers, :credential_type_number
    add_index :managers, :gender
    add_index :managers, :mobile_phone
  end
end
