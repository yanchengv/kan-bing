class Patient<ActiveRecord::Base
  belongs_to :doctor ,:foreign_key => :doctor_id
  has_many :users, :dependent => :destroy
  has_many :treatment_relationships
  has_many :docfriends, :through => :treatment_relationships, :source => :doctor
  has_many :appointmentblacklists
  has_many :appointments
  has_many :consultations
  attr_accessible :id,:name, :spell_code, :credential_type_number, :credential_type, :gender,
                  :birthday, :birthplace, :address, :nationality, :citizenship, :province, :county,
                  :photo, :marriage, :mobile_phone, :home_phone, :home_address, :contact, :contact_phone,
                  :home_postcode, :email, :introduction, :patient_ids, :education, :household, :occupation,
                  :orgnization, :orgnization_address, :insurance_type, :insurance_number,:id,:doctor_id, :is_public
  def self.get_by_name(*params)
    puts params
    patients = []
    params.each do |key|
      if key[:name] && key[:name].strip
        patients = Patient.where("name like ? OR spell_code like ?",
                                 "#{key[:name].strip}%", "#{key[:name].strip}%")
      else
        patients = Patient.where("name like ? OR spell_code like ?",
                                 "#{key[:patient_name].strip}%", "#{key[:patient_name].strip}%")
      end
    end
    return patients
  end
  def is_doctor?
    return false
  end
end