include SessionsHelper
class AdminReply < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :user_feedback , foreign_key: :user_feedback_id
  before_create :set_pk_code
  attr_accessible :id,
                  :user_id,
                  :user_feedback_id,
                  :reply_content
  def set_pk_code
    if self.id
      self.id = self.id.to_i
    else
      self.id = pk_id_rules
    end
  end
end
