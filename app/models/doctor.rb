class Doctor< ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :appointments
  has_many :patients
  has_many :treatment_relationships
  has_many :patfriends, :through => :treatment_relationships, :source  => :patient
  has_many :consultations, foreign_key: "owner_id", dependent: :destroy
  has_many :cons_orders, foreign_key: "owner_id", dependent: :destroy
  attr_accessible :id,:name, :spell_code, :credential_type, :credential_type_number, :gender, :birthday,
                  :birthplace, :address, :nationality, :citizenship, :province, :county, :photo, :marriage,
                  :mobile_phone, :home_phone, :home_address, :contact, :contact_phone, :home_postcode, :email,
                  :introduction, :hospital_id, :department_id, :professional_title, :position, :hire_date,
                  :certificate_number, :expertise, :degree, :is_control ,:type ,:id, :photo_path
  def self.find_by_name(name)
    if name.present?
      @doctor=Doctor.where("name LIKE '%#{name}%'")
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
end