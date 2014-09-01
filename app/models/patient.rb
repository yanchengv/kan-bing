include SessionsHelper
class Patient<ActiveRecord::Base
  before_create :pinyin,:treat_time
  before_update :pinyin
  before_create :set_pk_code
  belongs_to :doctor ,:foreign_key => :doctor_id
  has_one :user, :dependent => :destroy
  has_many :treatment_relationships, :dependent => :destroy
  has_many :docfriends, :through => :treatment_relationships, :source => :doctor
  has_many :appointmentblacklists, :dependent => :destroy
  has_many :appointments, :dependent => :destroy
  has_many :consultations, :dependent => :destroy
  has_many :blood_glucoses, :dependent => :destroy
  has_many :blood_pressures, :dependent => :destroy
  has_many :blood_fats, :dependent => :destroy
  has_many :blood_oxygens, :dependent =>:destroy
  has_many :weights, :dependent => :destroy
  has_many :us_reports,:dependent => :destroy
  has_many :inspection_reports,:dependent => :destroy
  attr_accessible :id,:name, :spell_code, :credential_type_number, :credential_type, :gender,:childbirth_date,
                  :birthday, :birthplace, :address, :nationality, :citizenship, :province, :county,
                  :photo, :marriage, :mobile_phone, :home_phone, :home_address, :contact, :contact_phone,
                  :home_postcode, :email, :introduction, :patient_ids, :education, :household, :occupation,:last_treat_time,:diseases_type,
                  :orgnization, :orgnization_address, :insurance_type, :insurance_number,:id,:doctor_id, :is_public,:p_user_id,:wechat,:created_at,:updated_at,
                  :verify_code,:is_activated, :is_checked,:verify_code_prit_count
  def pinyin
    self.spell_code = PinYin.abbr(self.name)

  end
  def treat_time
    if self.last_treat_time
      self.last_treat_time = self.last_treat_time
    else
      self.last_treat_time = Time.zone.now-30.days
    end
  end
  def self.get_by_name(*params)
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
  def set_pk_code
    if self.id&&self.id!=0
      self.id = id
    else
      self.id = pk_id_rules
    end
  end
end