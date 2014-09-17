#endcoding: utf-8
class Share < ActiveRecord::Base
  belongs_to  :note
  belongs_to  :user
  validates :note_id, uniqueness: { scope: :share_user_id,message: "已经为患者分享过该内容" }
  attr_accessible :note_id, :from_user_id, :from_user_name, :share_user_id, :share_user_name, :share_type, :link
end
