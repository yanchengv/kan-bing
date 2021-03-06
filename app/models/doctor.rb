include SessionsHelper
class Doctor< ActiveRecord::Base
  self.table_name = "doctors"
  self.inheritance_column = "ruby_type"
  before_create :set_pk_code,:set_default_value
  before_create :pinyin
  before_update :pinyin
  has_one :user, :dependent => :destroy
  has_many :appointments,:dependent => :destroy
  has_many :notes,:dependent => :destroy
  has_many :patients
  has_many :doctor_friendships, foreign_key: :doctor1_id,:dependent => :destroy
  has_many :doctor_friendships, foreign_key: :doctor2_id,:dependent => :destroy
  has_many :treatment_relationships, :dependent => :destroy
  has_many :patfriends, :through => :treatment_relationships, :source  => :patient
  has_many :consultations, foreign_key: "owner_id", dependent: :destroy
  has_many :cons_orders, foreign_key: "owner_id", dependent: :destroy
  belongs_to :hospital, :foreign_key => :hospital_id
  belongs_to :department, :foreign_key => :department_id
  has_many :appointments,:dependent => :destroy
  has_many :appointment_arranges,:dependent => :destroy
  has_many :appointment_schedules,:dependent => :destroy
  belongs_to :province1,:class_name => 'Province',foreign_key: :province_id
  belongs_to :city,foreign_key: :city_id
  attr_accessible :id,:name, :spell_code, :credential_type, :credential_type_number, :gender, :birthday,
                  :birthplace, :address, :nationality, :citizenship, :province, :county, :photo, :marriage,
                  :mobile_phone, :home_phone, :home_address, :contact, :contact_phone, :home_postcode, :email,
                  :introduction, :hospital_id, :department_id, :professional_title, :position, :hire_date,
                  :certificate_number, :expertise, :degree, :is_control, :photo_path,:dictionary_ids,
                  :hospital_name,
                  :department_name,
                  :province_name, :province_id,
                  :city_name,:city_id,
                  :rewards,:patient_id ,:sort,:indexpage,
                  :is_public, :graduated_from, :graduated_at, :research_paper, :wechat,:created_at, :updated_at, :code, :state ,:verify_code,:is_activated,:is_checked, :doctor_type #,:type

  scope :mainpage,-> { where(indexpage: true) }
  scope :descorder,->{ order('sort DESC')}
  #scope   #is not null
  scope :indexpage_and_asc ,->{ mainpage.order("sort ASC")}
  has_and_belongs_to_many :skills
  has_many :group_users
  has_many :groups ,:through => :group_users , :source => :group

  def pinyin
    self.spell_code = PinYin.abbr(self.name)
  end
  def set_default_value
    self.is_checked = 0
    self.is_activated = 0
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
    if self.id&&self.id!=0
      self.id = id
    else
      self.id = pk_id_rules
    end
  end

  def doctor_type
    self[:type]
  end
# setter for the "type" column
  def doctor_type=(s)
    self[:type] = s
  end
end