class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  validates :user_id, uniqueness: { scope: :group_id,
                                 message: "已经加入过该机构" }

  attr_accessible :group_id ,:user_id

end
