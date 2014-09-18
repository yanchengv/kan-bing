#endcoding: utf-8
class Share < ActiveRecord::Base
  belongs_to  :note
  belongs_to  :user
  after_create  :notice_user
  validates :note_id, uniqueness: { scope: :share_user_id,message: "已经为患者分享过该内容" }
  attr_accessible :note_id, :from_user_id, :from_user_name, :share_user_id, :share_user_name, :share_type, :link
  def notice_user
    shareMsg = ""
    shareMsg = self.from_user_name << " 给您分享了一篇文章 " #<< "/notes/"<< self.note_id.to_s
    #create msg tip
    Notification.create(user_id: self.share_user_id,
                        code: 11, content: self.note_id,
                        description: shareMsg,
                        start_time: Time.zone.now,
                        expired_time: Time.zone.now+60.days)
  end
end
