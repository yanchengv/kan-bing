class Doctor< ActiveRecord::Base
  attr_accessible :id,:name, :spell_code, :credential_type, :credential_type_number, :gender, :birthday,
                  :birthplace, :address, :nationality, :citizenship, :province, :county, :photo, :marriage,
                  :mobile_phone, :home_phone, :home_address, :contact, :contact_phone, :home_postcode, :email,
                  :introduction, :hospital_id, :department_id, :professional_title, :position, :hire_date,
                  :certificate_number, :expertise, :degree, :is_control ,:type ,:id, :photo_path
end