include SessionsHelper
class UserFeedback < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :admin_replies, dependent: :destroy
  before_create :set_pk_code
  attr_accessible :id,
                  :user_id,
                  :feedback_title,
                  :feedback_content
  def set_pk_code
    self.id = pk_id_rules
  end
end
