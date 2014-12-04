class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :doctor
  validates :user_id, uniqueness: { scope: :group_id,
                                 message: "已经加入过该机构" }

  attr_accessible :group_id ,:user_id ,:doctor_id ,:doctor_name

  after_create :haddler_save

  def haddler_save
    update_attributes(doctor_id: user.doctor_id ,doctor_name:user.doctor.name)
  end
end
