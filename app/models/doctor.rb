include SessionsHelper
class Doctor< ActiveRecord::Base
  self.table_name = "doctors"
  self.inheritance_column = "ruby_type"
  #before_create :set_pk_code
  before_create :pinyin
  before_update :pinyin
  has_one :user, :dependent => :destroy
  has_many :appointments,:dependent => :destroy
  has_many :patients
  has_many :treatment_relationships, :dependent => :destroy
  has_many :patfriends, :through => :treatment_relationships, :source  => :patient
  has_many :consultations, foreign_key: "owner_id", dependent: :destroy
  has_many :cons_orders, foreign_key: "owner_id", dependent: :destroy
  belongs_to :hospital, :foreign_key => :hospital_id
  belongs_to :department, :foreign_key => :department_id
  has_many :appointments,:dependent => :destroy
  has_many :appointment_arranges,:dependent => :destroy
  has_many :appointment_schedules,:dependent => :destroy
  attr_accessible :id,:name, :spell_code, :credential_type, :credential_type_number, :gender, :birthday,
                  :birthplace, :address, :nationality, :citizenship, :province, :county, :photo, :marriage,
                  :mobile_phone, :home_phone, :home_address, :contact, :contact_phone, :home_postcode, :email,
                  :introduction, :hospital_id, :department_id, :professional_title, :position, :hire_date,
                  :certificate_number, :expertise, :degree, :is_control ,:id, :photo_path,:dictionary_ids,
                  :is_public, :graduated_from, :graduated_at, :research_paper, :wechat,:created_at, :updated_at #,:type
  def pinyin
    self.spell_code = PinYin.abbr(self.name)
  end
  def self.find_by_name(name)
    if name.present?
      @doctor=Doctor.where('spell_code like ? or name like ?', "%#{name}%".downcase ,"%#{name}%")
    elsif name.blank?
      @doctor = Doctor.all
    end
  end
  def docfellows
    @friends = []
    @dfs1 = DoctorFriendship.where(doctor1_id:self.id)
    for df1 in @dfs1
      doc1=Doctor.find(df1.doctor2_id)
      @friends.push(doc1)
    end
    @dfs2 = DoctorFriendship.where(doctor2_id:self.id)
    for df2 in @dfs2
      doc2=Doctor.find(df2.doctor1_id)
      @friends.push(doc2)
    end
    return @friends
  end
  def is_doctor?
    return true
  end
  def set_pk_code
    self.id = pk_id_rules
  end

  def doctor_type
    self[:type]
  end
# setter for the "type" column
  def doctor_type=(s)
    self[:type] = s
  end
end