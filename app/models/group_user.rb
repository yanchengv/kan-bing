class GroupUser < ActiveRecord::Base
  self.table_name = "doctors_groups"
  belongs_to :group
  belongs_to :user
  belongs_to :doctor
  validates :user_id, uniqueness: { scope: :group_id,
                                 message: "已经加入过该机构" }
  before_save :check_doctor
  attr_accessible :group_id ,:user_id ,:doctor_id ,:doctor_name

  after_create :haddler_save

  def haddler_save
    bool = User.exists?(self.user_id)
    if bool
      user = User.find(self.user_id)
      if !user.doctor_id.nil?
        update_attributes(doctor_id: user.doctor_id, doctor_name: user.doctor.name)
      end
    end
    bool1 = Doctor.exists?(self.doctor_id)
    if bool1
      doctor = Doctor.find(self.doctor_id)
      if !doctor.user.nil?
        #update_attributes(user_id: doctor.user.id ,doctor_name:doctor.name)
      end
    end

  end

  def check_doctor

  end
end
