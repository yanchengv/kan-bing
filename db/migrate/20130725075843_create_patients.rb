class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name
      t.string :spell_code
      t.string :credential_type
      t.string :credential_type_number
      t.string :gender
      t.date :birthday
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
      t.string :patient_ids
      t.string :education
      t.string :household
      t.string :occupation
      t.string :orgnization
      t.string :orgnization_address
      t.string :insurance_type
      t.string :insurance_number
      t.belongs_to :doctor

      t.timestamps
    end
    execute "ALTER TABLE patients ADD PRIMARY KEY (id);"
  end
end
