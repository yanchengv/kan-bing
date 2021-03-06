#endcoding: utf-8
class Share < ActiveRecord::Base
  belongs_to  :note
  belongs_to  :user
  after_create :notice_user
  before_destroy :del_notifys
  validates :note_id, uniqueness: { scope: :share_user_id,message: "已经为患者分享过该内容" }
  attr_accessible :note_id, :from_user_id, :from_user_name, :share_user_id, :share_user_name, :share_type, :link

  def notice_user
    doc_name = self.from_user_name
    shareMsg = doc_name + " 给您分享了一篇文章 "
    #create msg tip
    Notification.create(user_id: self.share_user_id,
                        code: 11, content: self.note_id,
                        description: shareMsg,
                        start_time: Time.zone.now,
                        expired_time: Time.zone.now+60.days)
  end

  def del_notifys
    Notification.where(user_id: self.share_user_id, code: 11, content: self.note_id).destroy_all
  end
end
