class Patient<ActiveRecord::Base
  attr_accessible :id,:name, :spell_code, :credential_type_number, :credential_type, :gender,
                  :birthday, :birthplace, :address, :nationality, :citizenship, :province, :county,
                  :photo, :marriage, :mobile_phone, :home_phone, :home_address, :contact, :contact_phone,
                  :home_postcode, :email, :introduction, :patient_ids, :education, :household, :occupation,
                  :orgnization, :orgnization_address, :insurance_type, :insurance_number,:id,:doctor_id, :is_public
end